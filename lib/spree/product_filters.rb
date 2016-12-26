#encoding: utf-8
module Spree
  module Core
   module ProductFilters
      @@taxon = nil
      Spree::Product.add_search_scope :country_any do |*opts|
        filter = ProductFilters.country_filter(@@taxon)
        conds = opts.map {|o| filter[:conds][o]}.reject { |c| c.nil? }
        scope = conds.shift
        conds.each do |new_scope|
          scope = scope.or(new_scope)
        end
        Spree::Product.with_property('Страна').where(scope)
      end


      def ProductFilters.country_filter(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        @@taxon = taxon

        property = Spree::Property.find_by(name: 'Страна')

        scope = Spree::ProductProperty.where(property: property).
           joins(product: :taxons).
           where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)

        rows = scope.pluck(:value).uniq

        pp = Spree::ProductProperty.arel_table

        conds = Hash[*rows.map { |b| [b, pp[:value].eq(b)] }.flatten]

        {
          name:   'Страна',
          scope:  :country_any,
          conds:  conds,
          labels: rows.sort.map { |k| [k, k] }
        }
      end

   end
  end
end