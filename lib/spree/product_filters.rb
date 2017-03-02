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
          puts "123333-------------------------------"
          puts (scope.pluck(:value))
          Spree::Product.with_property('Страна').where(scope)
        end

      def ProductFilters.country_filter
          brand_property = Spree::Property.find_by(name: 'Страна')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).map{|p| p.value.split(",").first}.uniq.map(&:to_s) : []
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
          
        brands = scope.map{|p| p.value.split(",").first}.uniq
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
      Spree::Product.add_search_scope :brand_any do |*opts|
          conds = opts.map {|o| ProductFilters.brand_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Бренд').where(scope)
      end

      def ProductFilters.brand_filter
          brand_property = Spree::Property.find_by(name: 'Бренд')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Производитель',
            scope:  :brand_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_brand_any do |*opts|
        Spree::Product.brand_any(*opts)
      end

      def ProductFilters.select_brand_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Бренд')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Производитель',
          scope:  :select_brand_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end
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
          labels: (brands.sort_by(&:to_f)).map { |k| [k, k] }
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
          labels: (brands.sort_by(&:to_f)).map { |k| [k, k] }
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
          labels: (brands.sort_by(&:to_f)).map { |k| [k, k] }
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
          labels: (brands.sort_by(&:to_f)).map { |k| [k, k] }
        }
      end
 #================================================================================
  Spree::Product.add_search_scope :price_range_any do |*opts|
        conds = opts.map {|o| Spree::Core::ProductFilters.price_filter[:conds][o]}.reject { |c| c.nil? }
        scope = conds.shift
        conds.each do |new_scope|
          scope = scope.or(new_scope)
        end
        Spree::Product.joins(master: :default_price).where(scope)
      end

      def ProductFilters.format_price(amount)
        amount.to_i.to_s + " руб."
      end

      def ProductFilters.price_filter
        v = Spree::Price.arel_table
        conds = [ [ Spree.t(:under_price, price: format_price(1000))     , v[:amount].lteq(1000)],
                  [ "#{format_price(1000)} - #{format_price(5000)}"        , v[:amount].in(1000..5000)],
                  [ "#{format_price(5000)} - #{format_price(10000)}"        , v[:amount].in(5000..10000)],
                  [ "#{format_price(10000)} - #{format_price(25000)}"        , v[:amount].in(10000..25000)],
                  [ Spree.t(:or_over_price, price: format_price(25000)) , v[:amount].gteq(25000)]]
        {
          name:   Spree.t(:price_range),
          scope:  :price_range_any,
          conds:  Hash[*conds.flatten],
          labels: conds.map { |k,v| [k, k] }
        }
      end
   #=================================Тип=======================================
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
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
      #=================================Вид затвора=======================================
      Spree::Product.add_search_scope :shutter_type_any do |*opts|
          conds = opts.map {|o| ProductFilters.shutter_type_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Вид затвора').where(scope)
      end

      def ProductFilters.shutter_type_filter
          brand_property = Spree::Property.find_by(name: 'Вид затвора')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Вид затвора',
            scope:  :shutter_type_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_shutter_type_any do |*opts|
        Spree::Product.shutter_type_any(*opts)
      end

      def ProductFilters.select_shutter_type_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Вид затвора')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Вид затвора',
          scope:  :select_shutter_type_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
      #=================================Вид решетки=======================================
      Spree::Product.add_search_scope :lattice_type_any do |*opts|
          conds = opts.map {|o| ProductFilters.lattice_type_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Вид решетки').where(scope)
      end

      def ProductFilters.lattice_type_filter
          brand_property = Spree::Property.find_by(name: 'Вид решетки')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Вид решетки',
            scope:  :lattice_type_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_lattice_type_any do |*opts|
        Spree::Product.lattice_type_any(*opts)
      end

      def ProductFilters.select_lattice_type_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Вид решетки')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Вид решетки',
          scope:  :select_lattice_type_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
      #=================================Объем, л=======================================
      Spree::Product.add_search_scope :bulk_any do |*opts|
          conds = opts.map {|o| ProductFilters.bulk_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Объем, л').where(scope)
      end

      def ProductFilters.bulk_filter
          brand_property = Spree::Property.find_by(name: 'Объем, л')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Объем',
            scope:  :bulk_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_bulk_any do |*opts|
        Spree::Product.bulk_any(*opts)
      end

      def ProductFilters.select_bulk_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Объем, л')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Объем, л',
          scope:  :select_bulk_any,
          labels: (brands.sort_by(&:to_f)).map { |k| [k, k] }
        }
      end
      #=================================материал корпуса=======================================
      Spree::Product.add_search_scope :corpus_material_any do |*opts|
          conds = opts.map {|o| ProductFilters.corpus_material_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Материал корпуса').where(scope)
      end

      def ProductFilters.corpus_material_filter
          brand_property = Spree::Property.find_by(name: 'Материал корпуса')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Материал корпуса',
            scope:  :corpus_material_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_corpus_material_any do |*opts|
        Spree::Product.corpus_material_any(*opts)
      end

      def ProductFilters.select_corpus_material_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Материал корпуса')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Материал корпуса',
          scope:  :select_corpus_material_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Покрытие корпуса=======================================
      Spree::Product.add_search_scope :corpus_coating_any do |*opts|
          conds = opts.map {|o| ProductFilters.corpus_coating_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Материал корпуса').where(scope)
      end

      def ProductFilters.corpus_coating_filter
          brand_property = Spree::Property.find_by(name: 'Покрытие корпуса')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Покрытие корпуса',
            scope:  :corpus_coating_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_corpus_coating_any do |*opts|
        Spree::Product.corpus_coating_any(*opts)
      end

      def ProductFilters.select_corpus_coating_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Покрытие корпуса')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Покрытие корпуса',
          scope:  :select_corpus_coating_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
      #=================================Материал фасада=======================================
      Spree::Product.add_search_scope :fasade_material_any do |*opts|
          conds = opts.map {|o| ProductFilters.fasade_material_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Материал фасада').where(scope)
      end

      def ProductFilters.fasade_material_filter
          brand_property = Spree::Property.find_by(name: 'Материал фасада')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Материал фасада',
            scope:  :fasade_material_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_fasade_material_any do |*opts|
        Spree::Product.fasade_material_any(*opts)
      end

      def ProductFilters.select_fasade_material_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Материал фасада')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Материал фасада',
          scope:  :select_fasade_material_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
      #=================================Покрытие фасада=======================================
      Spree::Product.add_search_scope :fasade_coating_any do |*opts|
          conds = opts.map {|o| ProductFilters.fasade_coating_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Покрытие фасада').where(scope)
      end

      def ProductFilters.fasade_coating_filter
          brand_property = Spree::Property.find_by(name: 'Покрытие фасада')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Покрытие фасада',
            scope:  :fasade_coating_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_fasade_coating_any do |*opts|
        Spree::Product.fasade_coating_any(*opts)
      end

      def ProductFilters.select_fasade_coating_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Покрытие фасада')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Покрытие фасада',
          scope:  :select_fasade_coating_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
      #=================================Материал столешницы=======================================
      Spree::Product.add_search_scope :tabletop_material_any do |*opts|
          conds = opts.map {|o| ProductFilters.tabletop_material_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Материал столешницы').where(scope)
      end

      def ProductFilters.tabletop_material_filter
          brand_property = Spree::Property.find_by(name: 'Материал столешницы')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Материал столешницы',
            scope:  :tabletop_material_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_tabletop_material_any do |*opts|
        Spree::Product.tabletop_material_any(*opts)
      end

      def ProductFilters.select_tabletop_material_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Материал столешницы')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Материал столешницы',
          scope:  :select_tabletop_material_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
      #=================================Материал полотна двери=======================================
      Spree::Product.add_search_scope :door_material_any do |*opts|
          conds = opts.map {|o| ProductFilters.door_material_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Материал полотна двери').where(scope)
      end

      def ProductFilters.door_materiall_filter
          brand_property = Spree::Property.find_by(name: 'Материал полотна двери')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Материал полотна двери',
            scope:  :door_material_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_door_material_any do |*opts|
        Spree::Product.door_material_any(*opts)
      end

      def ProductFilters.select_door_material_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Материал полотна двери')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Материал полотна двери',
          scope:  :select_door_material_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
      #=================================Материал решетки=======================================
      Spree::Product.add_search_scope :lattice_material_any do |*opts|
          conds = opts.map {|o| ProductFilters.lattice_material_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Материал решетки').where(scope)
      end

      def ProductFilters.lattice_material_filter
          brand_property = Spree::Property.find_by(name: 'Материал решетки')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Материал решетки',
            scope:  :lattice_material_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_lattice_material_any do |*opts|
        Spree::Product.lattice_material_any(*opts)
      end

      def ProductFilters.select_lattice_material_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Материал решетки')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Материал решетки',
          scope:  :select_lattice_material_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
      #=================================Исполнение полотна двери=======================================
      Spree::Product.add_search_scope :door_execution_any do |*opts|
          conds = opts.map {|o| ProductFilters.door_execution_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Исполнение полотна двери').where(scope)
      end

      def ProductFilters.door_execution_filter
          brand_property = Spree::Property.find_by(name: 'Исполнение полотна двери')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Исполнение полотна двери',
            scope:  :door_execution_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_door_execution_any do |*opts|
        Spree::Product.door_execution_any(*opts)
      end

      def ProductFilters.select_door_execution_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Исполнение полотна двери')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Исполнение полотна двери',
          scope:  :select_door_execution_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
    #=================================Форма раковины=======================================
      Spree::Product.add_search_scope :sink_form_any do |*opts|
          conds = opts.map {|o| ProductFilters.sink_form_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Форма раковины').where(scope)
      end

      def ProductFilters.sink_form_filter
          brand_property = Spree::Property.find_by(name: 'Форма раковины')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Форма раковины',
            scope:  :sink_form_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_sink_form_any do |*opts|
        Spree::Product.sink_form_any(*opts)
      end

      def ProductFilters.select_sink_form_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Форма раковины')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Форма раковины',
          scope:  :select_sink_form_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
      #=================================Цвет раковины=======================================
      Spree::Product.add_search_scope :sink_color_any do |*opts|
          conds = opts.map {|o| ProductFilters.sink_color_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Цвет раковины').where(scope)
      end

      def ProductFilters.sink_color_filter
          brand_property = Spree::Property.find_by(name: 'Цвет раковины')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Цвет раковины',
            scope:  :sink_color_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_sink_color_any do |*opts|
        Spree::Product.sink_color_any(*opts)
      end

      def ProductFilters.select_sink_color_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Цвет раковины')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Цвет раковины',
          scope:  :select_sink_color_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Ориентация=======================================
      Spree::Product.add_search_scope :orientation_any do |*opts|
          conds = opts.map {|o| ProductFilters.orientation_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Ориентация').where(scope)
      end

      def ProductFilters.orientation_filter
          brand_property = Spree::Property.find_by(name: 'Ориентация')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Ориентация',
            scope:  :orientation_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_orientation_any do |*opts|
        Spree::Product.orientation_any(*opts)
      end

      def ProductFilters.select_orientation_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Ориентация')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Ориентация',
          scope:  :select_orientation_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
      #=================================Назначение=======================================
      Spree::Product.add_search_scope :appointment_any do |*opts|
          conds = opts.map {|o| ProductFilters.appointment_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Назначение').where(scope)
      end

      def ProductFilters.appointment_filter
          brand_property = Spree::Property.find_by(name: 'Назначение')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Назначение',
            scope:  :appointment_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_appointment_any do |*opts|
        Spree::Product.appointment_any(*opts)
      end

      def ProductFilters.select_appointment_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Назначение')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Назначение',
          scope:  :select_appointment_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Направление выпуска=======================================
      Spree::Product.add_search_scope :emission_direct_any do |*opts|
          conds = opts.map {|o| ProductFilters.emission_direct_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Направление выпуска').where(scope)
      end

      def ProductFilters.emission_direct_filter
          brand_property = Spree::Property.find_by(name: 'Направление выпуска')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Направление выпуска',
            scope:  :emission_direct_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_emission_direct_any do |*opts|
        Spree::Product.emission_direct_any(*opts)
      end

      def ProductFilters.select_emission_direct_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Направление выпуска')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Направление выпуска',
          scope:  :select_emission_direct_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
      #=================================Отверстия под смеситель=======================================
      Spree::Product.add_search_scope :door_presence_any do |*opts|
          conds = opts.map {|o| ProductFilters.door_presence_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Отверстия под смеситель').where(scope)
      end

      def ProductFilters.door_presence_filter
          brand_property = Spree::Property.find_by(name: 'Отверстия под смеситель')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Отверстия под смеситель',
            scope:  :door_presence_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_door_presence_any do |*opts|
        Spree::Product.door_presence_any(*opts)
      end

      def ProductFilters.select_door_presence_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Отверстия под смеситель')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Отверстия под смеситель',
          scope:  :select_door_presence_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Управление=======================================
      Spree::Product.add_search_scope :control_any do |*opts|
          conds = opts.map {|o| ProductFilters.control_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Управление').where(scope)
      end

      def ProductFilters.control_filter
          brand_property = Spree::Property.find_by(name: 'Управление')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Управление',
            scope:  :control_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_control_any do |*opts|
        Spree::Product.control_any(*opts)
      end

      def ProductFilters.select_control_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Управление')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Управление',
          scope:  :select_control_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Вид поддона=======================================
      Spree::Product.add_search_scope :type_of_pallet_any do |*opts|
          conds = opts.map {|o| ProductFilters.type_of_pallet_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Вид поддона').where(scope)
      end

      def ProductFilters.type_of_pallet_filter
          brand_property = Spree::Property.find_by(name: 'Вид поддона')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Вид поддона',
            scope:  :type_of_pallet_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_type_of_pallet_any do |*opts|
        Spree::Product.type_of_pallet_any(*opts)
      end

      def ProductFilters.select_type_of_pallet_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Вид поддона')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Вид поддона',
          scope:  :select_type_of_pallet_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Система гидромассажа=======================================
      Spree::Product.add_search_scope :hydromassage_any do |*opts|
          conds = opts.map {|o| ProductFilters.hydromassage_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Система гидромассажа').where(scope)
      end

      def ProductFilters.hydromassage_filter
          brand_property = Spree::Property.find_by(name: 'Система гидромассажа')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Гидромассаж',
            scope:  :hydromassage_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_hydromassage_any do |*opts|
        Spree::Product.hydromassage_any(*opts)
      end

      def ProductFilters.select_hydromassage_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Система гидромассажа')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Гидромассаж',
          scope:  :select_hydromassage_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Аэромассаж=======================================
      Spree::Product.add_search_scope :aeromassage_any do |*opts|
          conds = opts.map {|o| ProductFilters.aeromassage_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Аэромассаж').where(scope)
      end

      def ProductFilters.aeromassage_filter
          brand_property = Spree::Property.find_by(name: 'Аэромассаж')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Аэромассаж',
            scope:  :aeromassage_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_aeromassage_any do |*opts|
        Spree::Product.aeromassage_any(*opts)
      end

      def ProductFilters.select_aeromassage_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Аэромассаж')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Аэромассаж',
          scope:  :select_aeromassage_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Турецкая баня=======================================
      Spree::Product.add_search_scope :turkish_bath_any do |*opts|
          conds = opts.map {|o| ProductFilters.turkish_bath_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Турецкая баня').where(scope)
      end

      def ProductFilters.turkish_bath_filter
          brand_property = Spree::Property.find_by(name: 'Турецкая баня')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Турецкая баня',
            scope:  :turkish_bath_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_turkish_bath_any do |*opts|
        Spree::Product.turkish_bath_any(*opts)
      end

      def ProductFilters.select_turkish_bath_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Турецкая баня')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Турецкая баня',
          scope:  :select_turkish_bath_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end

 #=================================Финская сауна=======================================
      Spree::Product.add_search_scope :finnish_sauna_any do |*opts|
          conds = opts.map {|o| ProductFilters.finnish_sauna_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Финская сауна').where(scope)
      end

      def ProductFilters.finnish_sauna_filter
          brand_property = Spree::Property.find_by(name: 'Финская сауна')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Финская сауна',
            scope:  :finnish_sauna_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_finnish_sauna_any do |*opts|
        Spree::Product.finnish_sauna_any(*opts)
      end

      def ProductFilters.select_finnish_sauna_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Финская сауна')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Финская сауна',
          scope:  :select_finnish_sauna_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Подсветка=======================================
      Spree::Product.add_search_scope :backlight_any do |*opts|
          conds = opts.map {|o| ProductFilters.backlight_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Подсветка').where(scope)
      end

      def ProductFilters.backlight_filter
          brand_property = Spree::Property.find_by(name: 'Подсветка')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Подсветка',
            scope:  :backlight_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_backlight_any do |*opts|
        Spree::Product.backlight_any(*opts)
      end

      def ProductFilters.select_backlight_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Подсветка')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Подсветка',
          scope:  :select_backlight_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Освещение=======================================
      Spree::Product.add_search_scope :illumination_any do |*opts|
          conds = opts.map {|o| ProductFilters.illumination_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Освещение').where(scope)
      end

      def ProductFilters.illumination_filter
          brand_property = Spree::Property.find_by(name: 'Освещение')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Освещение',
            scope:  :illumination_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_illumination_any do |*opts|
        Spree::Product.illumination_any(*opts)
      end

      def ProductFilters.select_illumination_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Освещение')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Освещение',
          scope:  :select_illumination_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Встроенное сиденье=======================================
      Spree::Product.add_search_scope :built_in_seat_any do |*opts|
          conds = opts.map {|o| ProductFilters.built_in_seat_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Встроенное сиденье').where(scope)
      end

      def ProductFilters.built_in_seat_filter
          brand_property = Spree::Property.find_by(name: 'Встроенное сиденье')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Встроенное сиденье',
            scope:  :built_in_seat_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_built_in_seat_any do |*opts|
        Spree::Product.built_in_seat_any(*opts)
      end

      def ProductFilters.select_built_in_seat_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Встроенное сиденье')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Встроенное сиденье',
          scope:  :select_built_in_seat_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Конструкция дверей=======================================
      Spree::Product.add_search_scope :door_construction_any do |*opts|
          conds = opts.map {|o| ProductFilters.door_construction_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Конструкция дверей').where(scope)
      end

      def ProductFilters.door_construction_filter
          brand_property = Spree::Property.find_by(name: 'Конструкция дверей')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Конструкция дверей',
            scope:  :door_construction_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_door_construction_any do |*opts|
        Spree::Product.door_construction_any(*opts)
      end

      def ProductFilters.select_door_construction_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Конструкция дверей')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Конструкция дверей',
          scope:  :select_door_construction_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Ручной душ=======================================
      Spree::Product.add_search_scope :hand_shower_any do |*opts|
          conds = opts.map {|o| ProductFilters.hand_shower_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Ручной душ').where(scope)
      end

      def ProductFilters.hand_shower_filter
          brand_property = Spree::Property.find_by(name: 'Ручной душ')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Ручной душ',
            scope:  :hand_shower_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_hand_shower_any do |*opts|
        Spree::Product.hand_shower_any(*opts)
      end

      def ProductFilters.select_hand_shower_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Ручной душ')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Ручной душ',
          scope:  :select_hand_shower_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Тропический (верхний) душ=======================================
      Spree::Product.add_search_scope :tropic_shower_any do |*opts|
          conds = opts.map {|o| ProductFilters.tropic_shower_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Тропический (верхний) душ').where(scope)
      end

      def ProductFilters.tropic_shower_filter
          brand_property = Spree::Property.find_by(name: 'Тропический (верхний) душ')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Тропический душ (верхний)',
            scope:  :tropic_shower_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_tropic_shower_any do |*opts|
        Spree::Product.tropic_shower_any(*opts)
      end

      def ProductFilters.select_tropic_shower_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Тропический (верхний) душ')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Тропический душ (верхний)',
          scope:  :select_tropic_shower_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Радио=======================================
      Spree::Product.add_search_scope :radio_any do |*opts|
          conds = opts.map {|o| ProductFilters.radio_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Радио').where(scope)
      end

      def ProductFilters.radio_filter
          brand_property = Spree::Property.find_by(name: 'Радио')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Радио',
            scope:  :radio_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_radio_any do |*opts|
        Spree::Product.radio_any(*opts)
      end

      def ProductFilters.select_radio_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Радио')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Радио',
          scope:  :select_radio_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Сиденье с микролифтом=======================================
      Spree::Product.add_search_scope :seed_with_micro_any do |*opts|
          conds = opts.map {|o| ProductFilters.seed_with_micro_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Сиденье с микролифтом').where(scope)
      end

      def ProductFilters.seed_with_micro_filter
          brand_property = Spree::Property.find_by(name: 'Сиденье с микролифтом')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Сиденье с микролифтом',
            scope:  :seed_with_micro_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_seed_with_micro_any do |*opts|
        Spree::Product.seed_with_micro_any(*opts)
      end

      def ProductFilters.select_seed_with_micro_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Сиденье с микролифтом')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Сиденье с микролифтом',
          scope:  :select_seed_with_micro_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Безободковый=======================================
      Spree::Product.add_search_scope :rimless_any do |*opts|
          conds = opts.map {|o| ProductFilters.rimless_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Безободковый').where(scope)
      end

      def ProductFilters.rimless_filter
          brand_property = Spree::Property.find_by(name: 'Безободковый')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Безободковый',
            scope:  :rimless_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_rimless_any do |*opts|
        Spree::Product.rimless_any(*opts)
      end

      def ProductFilters.select_rimless_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Безободковый')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Безободковый',
          scope:  :select_rimless_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Функция биде=======================================
      Spree::Product.add_search_scope :bide_function_any do |*opts|
          conds = opts.map {|o| ProductFilters.bide_function_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Функция биде').where(scope)
      end

      def ProductFilters.bide_function_filter
          brand_property = Spree::Property.find_by(name: 'Функция биде')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Функция биде',
            scope:  :bide_function_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_bide_function_any do |*opts|
        Spree::Product.bide_function_any(*opts)
      end

      def ProductFilters.select_bide_function_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Функция биде')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Функция биде',
          scope:  :select_bide_function_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Режим слива воды=======================================
      Spree::Product.add_search_scope :water_drain_mode_any do |*opts|
          conds = opts.map {|o| ProductFilters.water_drain_mode_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Режим слива воды').where(scope)
      end

      def ProductFilters.water_drain_mode_filter
          brand_property = Spree::Property.find_by(name: 'Режим слива воды')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Режим слива воды',
            scope:  :water_drain_mode_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_water_drain_mode_any do |*opts|
        Spree::Product.water_drain_mode_any(*opts)
      end

      def ProductFilters.select_water_drain_mode_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Режим слива воды')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Режим слива воды',
          scope:  :select_water_drain_mode_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Метод крепления=======================================
      Spree::Product.add_search_scope :attach_method_any do |*opts|
          conds = opts.map {|o| ProductFilters.attach_method_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Метод крепления').where(scope)
      end

      def ProductFilters.attach_method_filter
          brand_property = Spree::Property.find_by(name: 'Метод крепления')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Метод крепления',
            scope:  :attach_method_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_attach_method_any do |*opts|
        Spree::Product.attach_method_any(*opts)
      end

      def ProductFilters.select_attach_method_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Метод крепления')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Метод крепления',
          scope:  :select_attach_method_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Подвод воды=======================================
      Spree::Product.add_search_scope :water_delivery_any do |*opts|
          conds = opts.map {|o| ProductFilters.water_delivery_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Подвод воды').where(scope)
      end

      def ProductFilters.water_delivery_filter
          brand_property = Spree::Property.find_by(name: 'Подвод воды')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Подвод воды',
            scope:  :water_delivery_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_water_delivery_any do |*opts|
        Spree::Product.water_delivery_any(*opts)
      end

      def ProductFilters.select_water_delivery_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Подвод воды')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Подвод воды',
          scope:  :select_water_delivery_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Крыло=======================================
      Spree::Product.add_search_scope :wing_any do |*opts|
          conds = opts.map {|o| ProductFilters.wing_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Крыло').where(scope)
      end

      def ProductFilters.wing_filter
          brand_property = Spree::Property.find_by(name: 'Крыло')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Крыло',
            scope:  :wing_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_wing_any do |*opts|
        Spree::Product.wing_any(*opts)
      end

      def ProductFilters.select_wing_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Крыло')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Крыло',
          scope:  :select_wing_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Расположение крыла=======================================
      Spree::Product.add_search_scope :wing_location_any do |*opts|
          conds = opts.map {|o| ProductFilters.wing_location_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Расположение крыла').where(scope)
      end

      def ProductFilters.wing_location_filter
          brand_property = Spree::Property.find_by(name: 'Расположение крыла')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Расположение крыла',
            scope:  :wing_location_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_wing_location_any do |*opts|
        Spree::Product.wing_location_any(*opts)
      end

      def ProductFilters.select_wing_location_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Расположение крыла')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Расположение крыла',
          scope:  :select_wing_location_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Число основных чаш=======================================
      Spree::Product.add_search_scope :main_cups_count_any do |*opts|
          conds = opts.map {|o| ProductFilters.main_cups_count_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Число основных чаш').where(scope)
      end

      def ProductFilters.main_cups_count_filter
          brand_property = Spree::Property.find_by(name: 'Число основных чаш')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Число основных чаш',
            scope:  :main_cups_count_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_main_cups_count_any do |*opts|
        Spree::Product.main_cups_count_any(*opts)
      end

      def ProductFilters.select_main_cups_count_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Число основных чаш')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Число основных чаш',
          scope:  :select_main_cups_count_any,
          labels: (brands.sort_by(&:to_f)).map { |k| [k, k] }
        }
      end
     #=================================Встраиваемая система=======================================
      Spree::Product.add_search_scope :emb_system_any do |*opts|
          conds = opts.map {|o| ProductFilters.emb_system_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Встраиваемая система').where(scope)
      end

      def ProductFilters.emb_system_filter
          brand_property = Spree::Property.find_by(name: 'Встраиваемая система')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Встраиваемая система',
            scope:  :emb_system_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_emb_system_any do |*opts|
        Spree::Product.emb_system_any(*opts)
      end

      def ProductFilters.select_emb_system_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Встраиваемая система')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Встраиваемая система',
          scope:  :select_emb_system_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Диаметр подключения, см=======================================
      Spree::Product.add_search_scope :connect_diametr_any do |*opts|
          conds = opts.map {|o| ProductFilters.connect_diametr_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Диаметр подключения, см').where(scope)
      end

      def ProductFilters.connect_diametr_filter
          brand_property = Spree::Property.find_by(name: 'Диаметр подключения, см')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Диаметр подключения',
            scope:  :connect_diametr_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_connect_diametr_any do |*opts|
        Spree::Product.connect_diametr_any(*opts)
      end

      def ProductFilters.select_connect_diametr_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Диаметр подключения, см')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Диаметр подключения',
          scope:  :select_connect_diametr_any,
          labels: (brands.sort_by(&:to_f)).map { |k| [k, k] }
        }
      end
     #=================================Диаметр слива, см=======================================
      Spree::Product.add_search_scope :drain_diametr_any do |*opts|
          conds = opts.map {|o| ProductFilters.drain_diametr_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Диаметр слива, см').where(scope)
      end

      def ProductFilters.drain_diametr_filter
          brand_property = Spree::Property.find_by(name: 'Диаметр слива, см')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Диаметр слива',
            scope:  :drain_diametr_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_drain_diametr_any do |*opts|
        Spree::Product.drain_diametr_any(*opts)
      end

      def ProductFilters.select_drain_diametr_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Диаметр слива, см')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Диаметр слива',
          scope:  :select_drain_diametr_any,
          labels: (brands.sort_by(&:to_f)).map { |k| [k, k] }
        }
      end
     #=================================Размещение=======================================
      Spree::Product.add_search_scope :placement_any do |*opts|
          conds = opts.map {|o| ProductFilters.placement_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Размещение').where(scope)
      end

      def ProductFilters.placement_filter
          brand_property = Spree::Property.find_by(name: 'Размещение')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Размещение',
            scope:  :placement_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_placement_any do |*opts|
        Spree::Product.placement_any(*opts)
      end

      def ProductFilters.select_placement_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Размещение')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Размещение',
          scope:  :select_placement_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
       #=================================Межосевое расстояние, см=======================================
      Spree::Product.add_search_scope :wheelbase_any do |*opts|
          conds = opts.map {|o| ProductFilters.wheelbase_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Межосевое расстояние, см').where(scope)
      end

      def ProductFilters.wheelbase_filter
          brand_property = Spree::Property.find_by(name: 'Межосевое расстояние, см')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Межосевое расстояние',
            scope:  :wheelbase_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_wheelbase_any do |*opts|
        Spree::Product.wheelbase_any(*opts)
      end

      def ProductFilters.select_wheelbase_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Межосевое расстояние, см')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Межосевое расстояние',
          scope:  :select_wheelbase_any,
          labels: (brands.sort_by(&:to_f)).map { |k| [k, k] }
        }
      end
     #=================================Вид нагрева=======================================
      Spree::Product.add_search_scope :heating_type_any do |*opts|
          conds = opts.map {|o| ProductFilters.heating_type_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Вид нагрева').where(scope)
      end

      def ProductFilters.heating_type_filter
          brand_property = Spree::Property.find_by(name: 'Вид нагрева')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Вид нагрева',
            scope:  :heating_type_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_heating_type_any do |*opts|
        Spree::Product.heating_type_any(*opts)
      end

      def ProductFilters.select_heating_type_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Вид нагрева')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Вид нагрева',
          scope:  :select_heating_type_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Мощность, Вт=======================================
      Spree::Product.add_search_scope :power_wt_any do |*opts|
          conds = opts.map {|o| ProductFilters.power_wt_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Мощность, Вт').where(scope)
      end

      def ProductFilters.power_wt_filter
          brand_property = Spree::Property.find_by(name: 'Мощность, Вт')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Мощность',
            scope:  :power_wt_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_power_wt_any do |*opts|
        Spree::Product.power_wt_any(*opts)
      end

      def ProductFilters.select_power_wt_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Мощность, Вт')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Мощность',
          scope:  :select_power_wt_any,
          labels: (brands.sort_by(&:to_f)).map { |k| [k, k] }
        }
      end
     #=================================Объем накопительной емкости, л=======================================
      Spree::Product.add_search_scope :tank_vol_any do |*opts|
          conds = opts.map {|o| ProductFilters.tank_vol_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Объем накопительной емкости, л').where(scope)
      end

      def ProductFilters.tank_vol_filter
          brand_property = Spree::Property.find_by(name: 'Объем накопительной емкости, л')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Объем бака',
            scope:  :tank_vol_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_tank_vol_any do |*opts|
        Spree::Product.tank_vol_any(*opts)
      end

      def ProductFilters.select_tank_vol_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Объем накопительной емкости, л')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Объем бака',
          scope:  :select_tank_vol_any,
          labels: (brands.sort_by(&:to_f)).map { |k| [k, k] }
        }
      end
     #=================================Вид нагревательного элемента=======================================
      Spree::Product.add_search_scope :heat_element_type_any do |*opts|
          conds = opts.map {|o| ProductFilters.heat_element_type_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Вид нагревательного элемента').where(scope)
      end

      def ProductFilters.heat_element_type_filter
          brand_property = Spree::Property.find_by(name: 'Вид нагревательного элемента')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Нагревательный элемент',
            scope:  :heat_element_type_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_heat_element_type_any do |*opts|
        Spree::Product.heat_element_type_any(*opts)
      end

      def ProductFilters.select_heat_element_type_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Вид нагревательного элемента')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Нагревательный элемент',
          scope:  :select_heat_element_type_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Подводка=======================================
      Spree::Product.add_search_scope :liner_any do |*opts|
          conds = opts.map {|o| ProductFilters.liner_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Подводка').where(scope)
      end

      def ProductFilters.liner_filter
          brand_property = Spree::Property.find_by(name: 'Подводка')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Подводка',
            scope:  :liner_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_liner_any do |*opts|
        Spree::Product.liner_any(*opts)
      end

      def ProductFilters.select_liner_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Подводка')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Подводка',
          scope:  :select_liner_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Внутреннее покрытие бака=======================================
      Spree::Product.add_search_scope :internal_coating_tank_any do |*opts|
          conds = opts.map {|o| ProductFilters.internal_coating_tank_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Внутреннее покрытие бака').where(scope)
      end

      def ProductFilters.internal_coating_tank_filter
          brand_property = Spree::Property.find_by(name: 'Внутреннее покрытие бака')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Внутреннее покрытие бака',
            scope:  :internal_coating_tank_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_internal_coating_tank_any do |*opts|
        Spree::Product.internal_coating_tank_any(*opts)
      end

      def ProductFilters.select_internal_coating_tank_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Внутреннее покрытие бака')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Внутреннее покрытие бака',
          scope:  :select_internal_coating_tank_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
     #=================================Оснащение=======================================
      Spree::Product.add_search_scope :equip_any do |*opts|
          conds = opts.map {|o| ProductFilters.equip_filter[:conds][o]}.reject { |c| c.nil? }
          scope = conds.shift
          conds.each do |new_scope|
            scope = scope.or(new_scope)
          end
          Spree::Product.with_property('Оснащение').where(scope)
      end

      def ProductFilters.equip_filter
          brand_property = Spree::Property.find_by(name: 'Оснащение')
          brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
          pp = Spree::ProductProperty.arel_table
          conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
          {
            name:   'Оснащение',
            scope:  :equip_any,
            conds:  conds,
            labels: (brands.sort).map { |k| [k, k] }
          }
      end

      Spree::Product.add_search_scope :select_equip_any do |*opts|
        Spree::Product.equip_any(*opts)
      end

      def ProductFilters.select_equip_any(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'Оснащение')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Оснащение',
          scope:  :select_equip_any,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end
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
