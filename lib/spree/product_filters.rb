#encoding: utf-8
module Spree
  module Core
   module ProductFilters
      Spree::Product.add_search_scope :country_any do |*opts|
          conds = opts.map {|o| ProductFilters.country_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Страна').where(scope)
        end

      def ProductFilters.country_filter
          brand_property = Spree::Property.find_by(name: 'Страна')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Страна',
            scope:  :country_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_country_any do |*opts|
        Spree::Product.country_any(*opts)
      end

      def ProductFilters.select_country_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Страна')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Страна',
          scope:  :select_country_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end



      Spree::Product.add_search_scope :type_any do |*opts|
          conds = opts.map {|o| ProductFilters.type_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Тип').where(scope)
      end

      def ProductFilters.type_filter
          brand_property = Spree::Property.find_by(name: 'Тип')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Тип',
            scope:  :type_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_type_any do |*opts|
        Spree::Product.type_any(*opts)
      end

      def ProductFilters.select_type_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Тип')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Тип',
          scope:  :select_type_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end


   end
  end
end