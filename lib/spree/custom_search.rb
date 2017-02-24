# encoding: utf-8
module Spree
  class CustomSearch < Spree::Core::Search::Base

    protected
    def add_search_scopes(base_scope)
      statement = nil
      search.each do |property_name, property_values|
        if property_name == "price_range_any"
          puts "custom 123312"
          scope_name = property_name.to_sym
               if base_scope.respond_to?(:search_scopes) && base_scope.search_scopes.include?(scope_name.to_sym)
                 base_scope = base_scope.send(scope_name, *property_values)
              end
            
        else
          name = property_name.gsub("_any", "").gsub("selective_","")
          puts "custom searhccccccc"
          property = Spree::Property.find_by_name(get_name(name))
          next unless property
          substatement = product_property[:property_id].eq(property.id).and(product_property[:value].eq(property_values.first))
          #substatement = Spree::Product.with_property_value(name, property_values.first)
          property_values[1..-1].each do |pv|
            substatement = substatement.or product_property[:value].eq(pv)
            #substatement = substatement.or Spree::Product.with_property_value(name, pv)
          end
          tail = product[:id].in(Spree::ProductProperty.select(:product_id).where(substatement).map(&:product_id))
          #ids = Spree::ProductProperty.select(:product_id).where(substatement).map(&:product_id)
          #tail = product[:id].in(ids)
          statement = statement.nil? ? tail : statement.and(tail)
        end
      end if search
      statement ? base_scope.where(statement) : base_scope
    end

    def prepare(params)
      super
      @properties[:product] = Spree::Product.arel_table
      @properties[:product_property] = Spree::ProductProperty.arel_table
    end

    def get_name(name)
        case name 
        when "select_country"
          "Страна"
        when "select_type"
          "Тип"
        when "select_color"
          "Цвет"
        when "select_brand"
          'Бренд'
        when 'select_material'
          'Материал'
        when 'select_forms'
          'Форма'
        when 'select_montaj'
          'Монтаж'
        when 'select_napolnoe'
          'Напольное'
        when 'select_nastennoe'
          'Настенное'
        when 'select_color'
          'Цвет'
        when 'select_width'
          'Ширина, см'
        when 'select_deep'
          'Глубина, см'
        when 'select_height'
          'Высота, см'
        when 'select_out_look'
          'Направление выпуска'
        when 'select_door_for'
          'Готовых отверстий для смесителя'
        when 'select_cap_in'
          'Крышка в комплекте'
        when 'select_seed_in'
          'Сиденье в комплекте'
        when 'select_mix_in'
          'Смеситель в комплекте'
        when 'select_guarantee'
          'Гарантия'
        when "select_equip"
          'Оснащение'
        when "select_internal_coating_tank"
          'Внутреннее покрытие бака'
        when 'select_liner'
            'Подводка'
        when 'select_heat_element_type'
            'Вид нагревательного элемента'
        when 'select_tank_vol'
            'Объем накопительной емкости, л'
        when 'select_power_wt'
            'Мощность, Вт'
        when "select_heating_type"
          "Вид нагрева"
        when 'select_wheelbase'
          'Межосевое расстояние, см'
        when 'select_placement'
          'Размещение'
        when 'select_drain_diametr'
          'Диаметр слива, см'
        when 'select_connect_diametr'
          'Диаметр подключения, см'
        when 'select_emb_system'
          'Встраиваемая система'
        when 'select_main_cups_count'
          'Число основных чаш'
        when 'select_wing_location'
          'Расположение крыла'
        when 'select_wing'
          'Крыло'
        when 'select_water_delivery'
          'Подвод воды'
        when 'select_attach_method'
          'Метод крепления'
        when 'select_water_drain_mode'
          'Режим слива воды'
        when 'select_bide_function'
          'Функция биде'
        when 'select_rimless'
          'Безободковый'
        when 'select_seed_with_micro'
          'Сиденье с микролифтом'
        when 'select_radio'
          'Радио'
        when 'select_tropic_shower'
          'Тропический (верхний) душ'
        when 'select_hand_shower'
          'Ручной душ'
        when 'select_door_construction'
          'Конструкция дверей'
        when 'select_built_in_seat'
          'Встроенное сиденье'
        when 'select_illumination'
          'Освещение'
        when 'select_backlight'
          'Подсветка'
        when 'select_finnish_sauna'
          'Финская сауна'
        when 'select_turkish_bath'
          'Турецкая баня'
        when 'select_aeromassage'
          'Аэромассаж'
        when 'select_hydromassage'
          'Система гидромассажа'
        when 'select_type_of_pallet'
          'Вид поддона'
        when 'select_control'
          'Управление'
        when 'select_door_presence'
          'Отверстия под смеситель'
        when 'select_emission_direct'
          'Направление выпуска'
        when 'select_appointment'
          'Назначение'
        when 'select_orientation'
          'Ориентация'
        when 'select_sink_color'
          'Цвет раковины'
        when 'select_door_execution'
          'Исполнение полотна двери'
        when 'select_sink_form'
          'Форма раковины'
        when 'select_lattice_material'
          'Материал решетки'
        when 'select_door_material'
          'Материал полотна двери'
        when 'select_tabletop_material'
          'Материал столешницы'
        when 'select_fasade_coating'
          'Покрытие фасада'
        when 'select_fasade_material'
          'Материал фасада'
        when 'select_corpus_coating'
          'Покрытие корпуса'
        when 'select_corpus_material'
          'Материал корпуса'
        when 'select_bulk'
          'Объем, л'
        when 'select_lattice_type'
          'Вид решетки'
        when 'select_shutter_type'
          'Вид затвора'
        when condition
        when condition


        end
    end
  end
end