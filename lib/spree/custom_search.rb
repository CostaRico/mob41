# encoding: utf-8
module Spree
  class CustomSearch < Spree::Core::Search::Base

    protected
    def add_search_scopes(base_scope)
      statement = nil
      search.each do |property_name, property_values|
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
        end

    end
  end
end