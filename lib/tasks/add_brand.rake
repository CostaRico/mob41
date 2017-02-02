task :add_brand_p => :environment do 
	#"Водонагреватели","Ванны из искусственного камня","Диспоузеры (измельчители)",
			# "Душевые боксы","Душевые кабины","Душ",
	files = [ "Инсталляции",
			"Кухонные мойки","Люки сантехнические","Писсуары",
			"Полотенцесушители","Раковины","Сифоны","Стальные ванны","Душевые боксы", "Биде",
			"Чугунные ванны","Теплые полы","Трапы, душевые лотки","Унитазы","Фильтры под мойку",
			"Уголки, ограждения, поддоны","Уголки, ограждения, поддоны_1","products_list",
			"products_list_1","products_list_2","products_list_3","Уголки, ограждения, поддоны"]
	path_to_file = Rails.root.to_s+"/public/product_list/"
	files.each do |file|
		list = JSON.parse((eval(File.read(path_to_file+file+".json"))).to_json)
		list.each do |item|
			puts item["brand"]
			add_brand_to_product(item)
		end
	end
end
	def add_brand_to_product(item)
		if item["brand"]
			@product = Spree::Product.find_by_code(item["code"].to_i)
			if @product
				@product.update_attributes(:brand => item["brand"])
				add_brand_to_props(@product, item["brand"])
			end
		else
			puts(" item #{item['code']} has no brand")

		end
	end

	def add_brand_to_props(product, b)
		if b
			data = {:property_name => "Бренд", :value => b} 
			Spree::Property.find_by_name(data[:property_name]) || Spree::Property.create(:name => data[:property_name], :presentation => data[:property_name])
			product.product_properties.create(data)
			product.update_attributes(:brand => b)
		end
	end
