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
            name:   'Страна бренда',
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
          name:   'Страна бренда',
          scope:  :select_country_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
      #=====================Тип========================
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
      #==============================Производство===============================
      # Spree::Product.add_search_scope :dev_any do |*opts|
      #     conds = opts.map {|o| ProductFilters.dev_filter[:conds][o]}.reject { |c| c.nil? }
      #     scope = conds.shift
      #     conds.each do |new_scope|
      #       scope = scope.or(new_scope)
      #     end
      #     Spree::Product.with_property('Производство').where(scope)
      # end

      # def ProductFilters.dev_filter
      #     brand_property = Spree::Property.find_by(name: 'Производство')
      #     brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
      #     pp = Spree::ProductProperty.arel_table
      #     conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
      #     {
      #       name:   'Производитель',
      #       scope:  :dev_any,
      #       conds:  conds,
      #       labels: (brands.sort).map { |k| [k, k] }
      #     }
      # end

      # Spree::Product.add_search_scope :select_dev_any do |*opts|
      #   Spree::Product.dev_any(*opts)
      # end

      # def ProductFilters.select_dev_any(taxon = nil)
      #   taxon ||= Spree::Taxonomy.first.root
      #   brand_property = Spree::Property.find_by(name: 'Производство')
      #   scope = Spree::ProductProperty.where(property: brand_property).
      #     joins(product: :taxons).
      #     where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
      #   brands = scope.pluck(:value).uniq
      #   {
      #     name:   'Производитель',
      #     scope:  :select_dev_any,
      #     labels: brands.sort.map { |k| [k, k] }
      #   }
      # end
    #===========================================================================
     Spree::Product.add_search_scope :material_any do |*opts|
          conds = opts.map {|o| ProductFilters.material_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Материал').where(scope)
      end

      def ProductFilters.material_filter
          brand_property = Spree::Property.find_by(name: 'Материал')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Материал',
            scope:  :material_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_material_any do |*opts|
        Spree::Product.material_any(*opts)
      end

      def ProductFilters.select_material_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Материал')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Материал',
          scope:  :select_material_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
  #================================Форма===============================
      Spree::Product.add_search_scope :forms_any do |*opts|
          conds = opts.map {|o| ProductFilters.forms_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Форма').where(scope)
      end

      def ProductFilters.forms_filter
          brand_property = Spree::Property.find_by(name: 'Форма')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Форма',
            scope:  :forms_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_forms_any do |*opts|
        Spree::Product.forms_any(*opts)
      end

      def ProductFilters.select_forms_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Форма')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Форма',
          scope:  :select_forms_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end

    #=============================Монтаж > Способ монтажа=======================================
    Spree::Product.add_search_scope :montaj_any do |*opts|
          conds = opts.map {|o| ProductFilters.montaj_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Монтаж').where(scope)
      end

      def ProductFilters.montaj_filter
          brand_property = Spree::Property.find_by(name: 'Монтаж')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Способ монтажа',
            scope:  :montaj_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_montaj_any do |*opts|
        Spree::Product.montaj_any(*opts)
      end

      def ProductFilters.select_montaj_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Монтаж')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Способ монтажа',
          scope:  :select_montaj_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
    #=================================Напольное > напольный=======================================
        Spree::Product.add_search_scope :napolnoe_any do |*opts|
          conds = opts.map {|o| ProductFilters.napolnoe_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Напольное').where(scope)
      end

      def ProductFilters.napolnoe_filter
          brand_property = Spree::Property.find_by(name: 'Напольное')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'напольный',
            scope:  :napolnoe_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_napolnoe_any do |*opts|
        Spree::Product.napolnoe_any(*opts)
      end

      def ProductFilters.select_napolnoe_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Напольное')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'напольный',
          scope:  :select_napolnoe_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
    #=================================Настенное > подвесной=======================================
        Spree::Product.add_search_scope :nastennoe_any do |*opts|
          conds = opts.map {|o| ProductFilters.nastennoe_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Настенное').where(scope)
      end

      def ProductFilters.nastennoe_filter
          brand_property = Spree::Property.find_by(name: 'Настенное')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'подвесной',
            scope:  :nastennoe_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_nastennoe_any do |*opts|
        Spree::Product.nastennoe_any(*opts)
      end

      def ProductFilters.select_nastennoe_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Настенное')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'подвесной',
          scope:  :select_nastennoe_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
    #==================================Цвет======================================
      Spree::Product.add_search_scope :color_any do |*opts|
          conds = opts.map {|o| ProductFilters.color_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Цвет').where(scope)
      end

      def ProductFilters.color_filter
          brand_property = Spree::Property.find_by(name: 'Цвет')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Цвет',
            scope:  :color_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_color_any do |*opts|
        Spree::Product.color_any(*opts)
      end

      def ProductFilters.select_color_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Цвет')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Цвет',
          scope:  :select_color_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
    #=================================Ширина, см > Ширина=======================================
      Spree::Product.add_search_scope :width_any do |*opts|
          conds = opts.map {|o| ProductFilters.width_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Ширина, см').where(scope)
      end

      def ProductFilters.width_filter
          brand_property = Spree::Property.find_by(name: 'Ширина, см')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Ширина',
            scope:  :width_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_width_any do |*opts|
        Spree::Product.width_any(*opts)
      end

      def ProductFilters.select_width_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Ширина, см')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Ширина',
          scope:  :select_width_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
    #================================Глубина, см > Глубина========================================
      Spree::Product.add_search_scope :deep_any do |*opts|
          conds = opts.map {|o| ProductFilters.deep_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Глубина, см').where(scope)
      end

      def ProductFilters.deep_filter
          brand_property = Spree::Property.find_by(name: 'Глубина, см')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Глубина',
            scope:  :deep_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_deep_any do |*opts|
        Spree::Product.deep_any(*opts)
      end

      def ProductFilters.select_deep_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Глубина, см')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Глубина',
          scope:  :select_deep_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
    #===================================Высота, см > Высота=====================================
      Spree::Product.add_search_scope :height_any do |*opts|
          conds = opts.map {|o| ProductFilters.height_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Высота, см').where(scope)
      end

      def ProductFilters.height_filter
          brand_property = Spree::Property.find_by(name: 'Высота, см')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Высота',
            scope:  :height_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_height_any do |*opts|
        Spree::Product.height_any(*opts)
      end

      def ProductFilters.select_height_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Высота, см')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Высота',
          scope:  :select_height_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
    #==================================Направление выпуска======================================
      Spree::Product.add_search_scope :out_look_any do |*opts|
          conds = opts.map {|o| ProductFilters.out_look_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Направление выпуска').where(scope)
      end

      def ProductFilters.out_look_filter
          brand_property = Spree::Property.find_by(name: 'Направление выпуска')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Направление выпуска',
            scope:  :out_look_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_out_look_any do |*opts|
        Spree::Product.out_look_any(*opts)
      end

      def ProductFilters.select_out_look_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Направление выпуска')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Направление выпуска',
          scope:  :select_out_look_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
    #=============================Готовых отверстий для смесителя > Готовых отверстий под смеситель===========================================
      Spree::Product.add_search_scope :door_for_any do |*opts|
          conds = opts.map {|o| ProductFilters.door_for_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Готовых отверстий для смесителя').where(scope)
      end

      def ProductFilters.door_for_filter
          brand_property = Spree::Property.find_by(name: 'Готовых отверстий для смесителя')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Готовых отверстий под смеситель',
            scope:  :door_for_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_door_for_any do |*opts|
        Spree::Product.door_for_any(*opts)
      end

      def ProductFilters.select_door_for_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Готовых отверстий для смесителя')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Готовых отверстий под смеситель',
          scope:  :select_door_for_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
    #=================================Крышка в комплекте=======================================
      Spree::Product.add_search_scope :cap_in_any do |*opts|
          conds = opts.map {|o| ProductFilters.cap_in_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Крышка в комплекте').where(scope)
      end

      def ProductFilters.cap_in_filter
          brand_property = Spree::Property.find_by(name: 'Крышка в комплекте')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Крышка в комплекте',
            scope:  :cap_in_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_cap_in_any do |*opts|
        Spree::Product.cap_in_any(*opts)
      end

      def ProductFilters.select_cap_in_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Крышка в комплекте')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Крышка в комплекте',
          scope:  :select_cap_in_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
    #================================Сиденье в комплекте========================================
      Spree::Product.add_search_scope :seed_in_any do |*opts|
          conds = opts.map {|o| ProductFilters.seed_in_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Сиденье в комплекте').where(scope)
      end

      def ProductFilters.seed_in_filter
          brand_property = Spree::Property.find_by(name: 'Сиденье в комплекте')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Сиденье в комплекте',
            scope:  :seed_in_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_seed_in_any do |*opts|
        Spree::Product.seed_in_any(*opts)
      end

      def ProductFilters.select_seed_in_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Сиденье в комплекте')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Сиденье в комплекте',
          scope:  :select_seed_in_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
    #================================Смеситель в комплекте========================================
     Spree::Product.add_search_scope :mix_in_any do |*opts|
          conds = opts.map {|o| ProductFilters.mix_in_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Смеситель в комплекте').where(scope)
      end

      def ProductFilters.mix_in_filter
          brand_property = Spree::Property.find_by(name: 'Смеситель в комплекте')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Смеситель в комплекте',
            scope:  :mix_in_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_mix_in_any do |*opts|
        Spree::Product.mix_in_any(*opts)
      end

      def ProductFilters.select_mix_in_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Смеситель в комплекте')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Смеситель в комплекте',
          scope:  :select_mix_in_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
    #=================================Гарантия=======================================
      Spree::Product.add_search_scope :guarantee_any do |*opts|
          conds = opts.map {|o| ProductFilters.guarantee_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Гарантия').where(scope)
      end

      def ProductFilters.guarantee_filter
          brand_property = Spree::Property.find_by(name: 'Гарантия')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Гарантия',
            scope:  :guarantee_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_guarantee_any do |*opts|
        Spree::Product.guarantee_any(*opts)
      end

      def ProductFilters.select_guarantee_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Гарантия')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Гарантия',
          scope:  :select_guarantee_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
 #================================================================================
   end
  end
end
# Производство > Производитель
# Страна > Страна бренда
# Материал 
# Форма
# Монтаж > Способ монтажа 
# Напольное > напольный
# Настенное > подвесной
# Цвет
# Ширина, см > Ширина
# 35.5 > 35.5 см
# Глубина, см > Глубина
# 53 > 53 см
# Высота, см > Высота
# 38.5 > 38.5 см
# Направление выпуска 
# Готовых отверстий для смесителя > Готовых отверстий под смеситель
# Крышка в комплекте
# Сиденье в комплекте
# Смеситель в комплекте
# Гарантия