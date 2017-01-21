task :add_products => :environment do 
	first_level = [{:name => "Мебель для ванной", :url => "/mebel_dlja_vannoj_komnaty/"}, {:name => "Сантехника", :url => nil}]
	second_level =  [{:name=>"Акриловые ванны", :url=>"/vanny/akrilovye/"}, {:name=>"Чугунные ванны", :url=>"/vanny/chugunnye/"}, 
		{:name=>"Стальные ванны", :url=>"/vanny/stalnye/"}, {:name=>"Ванны из искусственного камня", :url=>"/vanny/iz_iskusstvennogo_kamnya/"}, 
		{:name=>"Унитазы", :url=>"/unitazy/"}, {:name=>"Раковины", :url=>"/rakoviny/"}, 
		{:name=>"Смесители", :url=>"/smesiteli/"}, {:name=>"Душ", :url=>"/dushevaja_programma/"}, 
		{:name=>"Душевые кабины", :url=>"/dushevye_kabiny/"}, {:name=>"Душевые боксы", :url=>"/dushevye_boksy/"}, 
		{:name=>"Уголки, ограждения, поддоны", :url=>"/dushevye_ugolki/"}, {:name=>"Кухонные мойки", :url=>"/kuhonnye_mojki/"}, 
		{:name=>"Инсталляции", :url=>"/installjacii/"}, {:name=>"Биде", :url=>"/bide/"}, 
		{:name=>"Писсуары", :url=>"/pissuary/"}, {:name=>"Сифоны", :url=>"/sifony/"}, 
		{:name=>"Полотенцесушители", :url=>"/polotencesushiteli/"}, {:name=>"Водонагреватели", :url=>"/teplotehnika/vodonagrevateli/"}, 
		{:name=>"Трапы, душевые лотки", :url=>"/trapy_i_dushevye_lotki/"}, {:name=>"Диспоузеры (измельчители)", :url=>"/kuhonnye_mojki/dispouzery/"}, 
		{:name=>"Фильтры под мойку", :url=>"/filtry_dlja_vody/pod_moyku/"}, 
		{:name=>"Люки сантехнические", :url=>"/santehnicheskie_ljuki/"}, {:name=>"Теплые полы", :url=>"/teplotehnika/teplye_poly/"}] 
	files = ["Биде"]#,"Водонагреватели","Чугунные ванны","Ванны из искусственного камня","Диспоузеры (измельчители)","Душевые боксы","Душевые кабины","Душ", "Инсталляции"]
	path_to_file = Rails.root.to_s+"/public/product_list/"
	init_taxons(first_level, second_level)
	files.each do |file|
		list = JSON.parse(File.read(path_to_file+file+".json"))
		list.each do |item|
			pars_product(item, file)
		end
	end

end

def init_taxons(first_level, second_level)
	@taxonomy = Spree::Taxonomy.find_by_id(1)|| Spree::Taxonomy.create(:name => "Сантехника")
	@g_taxon = Spree::Taxon.find_by_id(1)
	
	first_level.each do |tax|
		Spree::Taxon.find_by_name(tax[:name]) || Spree::Taxon.create(:name => tax[:name], :parent_id => @g_taxon.id, :taxonomy_id => @taxonomy.id)
	end

	parent = Spree::Taxon.find_by_name(first_level.last[:name]).id
	second_level.each do |tax|
		Spree::Taxon.find_by_name(tax[:name]) || Spree::Taxon.create(:name => tax[:name], :parent_id => parent, :taxonomy_id => @taxonomy.id)
	end
end
def prf
	{"name"=>"Биде напольное Roca Victoria 357390000", "description"=>" ", 
		"code"=>"105793", "price"=>7335, 
		"properties"=>[{"key"=>"Артикул", "value"=>"357390000 (357394000)"}, 
					   {"key"=>"Монтаж", "value"=>"напольное"}, 
					   {"key"=>"Материал", "value"=>"фаянс"}, 
					   {"key"=>"Ширина, см", "value"=>"35.5"}, {"key"=>"Глубина, см", "value"=>"53"}, 
					   {"key"=>"Высота, см", "value"=>"38.5"}, {"key"=>"Гарантия", "value"=>"10 лет"},  
					   {"key"=>"Крышка в комплекте", "value"=>"приобретается отдельно"}, 
					   {"key"=>"Сиденье в комплекте", "value"=>"нет"}, 
					   {"key"=>"Смеситель в комплекте", "value"=>"нет"}], 
		"complect_codes"=>[], 
		"images"=>["http://santehnika-online.ru//upload/iblock/eb8/BIDE_ROCA_VICTORIA__5793_1.JPG", 
				"http://santehnika-online.ru//upload/iblock/3fd/BIDE_ROCA_VICTORIA__5793_2.JPG", 
				"http://santehnika-online.ru//upload/iblock/267/BIDE_ROCA_VICTORIA__5793_3.JPG", 
				"http://santehnika-online.ru//upload/iblock/e61/BIDE_ROCA_VICTORIA__5793_4.JPG", 
				"http://santehnika-online.ru//upload/iblock/3e2/BIDE_ROCA_VICTORIA__5793_5.JPG", 
				"http://santehnika-online.ru//upload/iblock/c1d/BIDE_ROCA_VICTORIA__5793_7.JPG", 
				"http://santehnika-online.ru//upload/iblock/463/BIDE_ROCA_VICTORIA__5793_6.JPG"], 
	"taxon_id"=>16}
end
	
def pars_product(item, folder)
	@product = Spree::Product.find_by_code(item["code"].to_i)
	if @product.nil?
		puts "insert product"
		@product = insert_product(item)
	else
		puts "Product #{item['name']} with code #{item['code']} already exist"
	end
	add_properties(@product, item['properties']) if @product.product_properties.empty?
	add_images(@product, item['images'], folder)
end

def insert_product(item)
	@product = Spree::Product.create(:name => item['name'], :price => item["price"], :description => item["description"], :code => item["code"],
									 :shipping_category_id => "1", :taxon_ids => [item['taxon_id']], :available_on => Time.current)
end

def add_properties(product, properties_data)
	properties_data = properties_data.map{|p| {:property_name => p['key'], :value => p['value']} if p['key'] != "Артикул"}.compact
	properties_data.each do |param|
		Spree::Property.find_by_name(param[:property_name]) || Spree::Property.create(:name => param[:property_name], :presentation => param[:property_name])
	end
	product.product_properties.create(properties_data)
end

def add_images(product, image_list, folder)
	image_list.each do |pic|
		current_img = product.images.find_by_attachment_file_name(pic.split("/").last)
		if current_img
			puts "image #{current_img} already exists"
		else
			insert_img(product, pic, folder)
		end
	end
end

def insert_img(product, pic, folder_name)
	url_to_img = "/home/41km.ru/web/images/#{folder_name}/pic.split('/').last"
	begin
		img = product.images.create(:attachment => url_to_img)
		puts "#{img.attachment.url}" if img.save 
	rescue => e
		puts "--!!!!!-- image error --> #{e} --!!!!!!--"
	end
end