Spree::ProductsController.class_eval do 
    helper_method :sorting_param
    alias_method :old_index, :index

    def index
      old_index 
      # @products = @products.reorder(" ").send(:ascend_by_master_price)
    end

    def sorting_param
      params[:sorting].try(:to_sym) || default_sorting
    end

    def show
      prop_names = ["Страна","Тип","Цвет",'Бренд','Материал','Форма','Монтаж',
        'Напольное','Настенное','Цвет','Ширина, см','Глубина, см','Высота, см',
        'Направление выпуска','Готовых отверстий для смесителя','Крышка в комплекте',
        'Сиденье в комплекте','Смеситель в комплекте','Гарантия','Оснащение',
        'Внутреннее покрытие бака', 'Подводка', 'Вид нагревательного элемента',
        'Объем накопительной емкости, л', 'Мощность, Вт',"Вид нагрева",'Межосевое расстояние, см',
        'Размещение','Диаметр слива, см','Диаметр подключения, см',
        'Встраиваемая система','Число основных чаш','Расположение крыла','Крыло','Подвод воды',
        'Метод крепления','Режим слива воды','Функция биде','Безободковый','Сиденье с микролифтом',
        'Радио','Тропический (верхний) душ','Ручной душ','Конструкция дверей','Встроенное сиденье',
        'Освещение','Подсветка','Финская сауна','Турецкая баня','Аэромассаж','Система гидромассажа',
        'Вид поддона','Управление','Отверстия под смеситель','Направление выпуска','Назначение','Ориентация',
        'Цвет раковины','Исполнение полотна двери','Форма раковины','Материал решетки','Материал полотна двери',
        'Материал столешницы','Покрытие фасада','Материал фасада','Покрытие корпуса','Материал корпуса',
        'Объем, л','Вид решетки','Вид затвора''Фурнитура',
        'Дополнительные функции','Антискользящее покрытие','Ножки','Каркас','Подголовник','Ручки','Слив-перелив']
        succ_prop_ids = Spree::Property.where(:name => prop_names).pluck(:id)
      @variants = @product.variants_including_master.
                           spree_base_scopes.
                           active(current_currency).
                           includes([:option_values, :images])
      @product_properties = @product.product_properties.includes(:property).where(:property_id => succ_prop_ids)
      @taxon = params[:taxon_id].present? ? Spree::Taxon.find(params[:taxon_id]) : @product.taxons.first
      redirect_if_legacy_path
    end
    private

    def sorting_scope
      allowed_sortings.include?(sorting_param) ? sorting_param : default_sorting
    end

    def default_sorting
      :ascend_by_updated_at
    end

    def allowed_sortings
      [:descend_by_master_price, :ascend_by_master_price, :ascend_by_updated_at]
    end

end