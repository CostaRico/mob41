task :run_parser => :environment do 
	@base_url = "http://santehnika-online.ru"
	# first_level = [{:name => "Мебель для ванной", :url => "/mebel_dlja_vannoj_komnaty/"}, {:name => "Сантехника", :url => nil}]
	# second_level =  [{:name=>"Акриловые ванны", :url=>"/vanny/akrilovye/"}, {:name=>"Чугунные ванны", :url=>"/vanny/chugunnye/"}, 
	# 	{:name=>"Стальные ванны", :url=>"/vanny/stalnye/"}, {:name=>"Ванны из искусственного камня", :url=>"/vanny/iz_iskusstvennogo_kamnya/"}, 
	# 	{:name=>"Унитазы", :url=>"/unitazy/"}, {:name=>"Раковины", :url=>"/rakoviny/"}, 
	# 	{:name=>"Смесители", :url=>"/smesiteli/"}, {:name=>"Душ", :url=>"/dushevaja_programma/"}, 
	# 	{:name=>"Душевые кабины", :url=>"/dushevye_kabiny/"}, {:name=>"Душевые боксы", :url=>"/dushevye_boksy/"}, 
	# 	{:name=>"Уголки, ограждения, поддоны", :url=>"/dushevye_ugolki/"}, {:name=>"Кухонные мойки", :url=>"/kuhonnye_mojki/"}, 
	# 	{:name=>"Инсталляции", :url=>"/installjacii/"}, {:name=>"Биде", :url=>"/bide/"}, 
	# 	{:name=>"Писсуары", :url=>"/pissuary/"}, {:name=>"Сифоны", :url=>"/sifony/"}, 
	# 	{:name=>"Полотенцесушители", :url=>"/polotencesushiteli/"}, {:name=>"Водонагреватели", :url=>"/teplotehnika/vodonagrevateli/"}, 
	# 	{:name=>"Трапы, душевые лотки", :url=>"/trapy_i_dushevye_lotki/"}, {:name=>"Диспоузеры (измельчители)", :url=>"/kuhonnye_mojki/dispouzery/"}, 
	# 	{:name=>"Фильтры под мойку", :url=>"/filtry_dlja_vody/pod_moyku/"}, 
	# 	{:name=>"Люки сантехнические", :url=>"/santehnicheskie_ljuki/"}, {:name=>"Теплые полы", :url=>"/teplotehnika/teplye_poly/"}] 
	# #index_page = open_uri(base_url)
	# parse_categories(first_level, second_level)
	# @taxons = Spree::Taxon.all.to_a
	# complex_array = [{:name => "Мебель для ванной", :url => "/mebel_dlja_vannoj_komnaty/"},
	# 	{:name=>"Акриловые ванны", :url=>"/vanny/akrilovye/"}, {:name=>"Чугунные ванны", :url=>"/vanny/chugunnye/"}, 
	# 	{:name=>"Стальные ванны", :url=>"/vanny/stalnye/"}, {:name=>"Ванны из искусственного камня", :url=>"/vanny/iz_iskusstvennogo_kamnya/"}, 
	# 	{:name=>"Унитазы", :url=>"/unitazy/"}, {:name=>"Раковины", :url=>"/rakoviny/"}, 
	# 	{:name=>"Смесители", :url=>"/smesiteli/"}, {:name=>"Душ", :url=>"/dushevaja_programma/"}, 
	# 	{:name=>"Душевые кабины", :url=>"/dushevye_kabiny/"}, {:name=>"Душевые боксы", :url=>"/dushevye_boksy/"}, 
	# 	{:name=>"Уголки, ограждения, поддоны", :url=>"/dushevye_ugolki/"}, {:name=>"Кухонные мойки", :url=>"/kuhonnye_mojki/"}, 
	# 	{:name=>"Инсталляции", :url=>"/installjacii/"}, {:name=>"Биде", :url=>"/bide/"}, 
	# 	{:name=>"Писсуары", :url=>"/pissuary/"}, {:name=>"Сифоны", :url=>"/sifony/"}, 
	# 	{:name=>"Полотенцесушители", :url=>"/polotencesushiteli/"}, {:name=>"Водонагреватели", :url=>"/teplotehnika/vodonagrevateli/"}, 
	# 	{:name=>"Трапы, душевые лотки", :url=>"/trapy_i_dushevye_lotki/"}, {:name=>"Диспоузеры (измельчители)", :url=>"/kuhonnye_mojki/dispouzery/"}, 
	# 	{:name=>"Фильтры под мойку", :url=>"/filtry_dlja_vody/pod_moyku/"}, 
	# 	{:name=>"Люки сантехнические", :url=>"/santehnicheskie_ljuki/"}, {:name=>"Теплые полы", :url=>"/teplotehnika/teplye_poly/"}]
	# complex_array = complex_array.map{|arr| arr.merge(:taxon_id => @taxons.detect{|w| w.name == arr[:name]}.id)}
	# puts "#{complex_array}"
	# @products = []
	# complex_array.each do |item|
	# 	puts "--- start parsing #{item[:name]} ---"
	# 	products = get_items_links(item[:url])
	# 	path_to_file = Rails.root.to_s+"/public/#{item[:name]}.json"
	# 	File.open(path_to_file, "w+") do |f|
	# 		f.write(products.to_json)
	# 	end 
	# 	#@products += products.map{|a| {:url => @base_url+a, :taxon_id => item[:taxon_id]}}
	# 	puts "---- end parsing #{item[:name]} ----"
	# end	
	# puts "===============total=============="
	 # files=["Биде", "Ванны из искусственного камня", "Водонагреватели", "Диспоузеры (измельчители)","Душевые боксы", "Душевые кабины", "Душ",
	 #  	"Инсталляции", "Кухонные мойки", "Люки сантехнические", "Писсуары", "Полотенцесушители", "Раковины", "Сифоны", "Смесители", "Стальные ванны",
	 #  	"Теплые полы", "Трапы, душевые лотки", "Уголки, ограждения, поддоны", "Унитазы", "Фильтры под мойку", "products_list" ]
	#file = "http://santehnika-online.ru//product/mebel_dlya_vannoy_briklaer_lyuchiya_100_belyy_glyanets/"
	#files =["Водонагреватели","Чугунные ванны","Биде","Ванны из искусственного камня","Диспоузеры (измельчители)","Душевые боксы","Душевые кабины","Душ", "Инсталляции","Кухонные мойки","Люки сантехнические",
	#"Писсуары", "Полотенцесушители","Раковины"]
	files = ["Раковины"]
	files.each do |file|
		path = Rails.root.to_s + "/public/product_list/#{file}.json" 
		path_to_file = Rails.root.to_s+"/public/product_links/#{file}.json"
		product_parser(@base_url, path_to_file, path)
	end
end	

def product_parser(base_url, file, path_to_file)
	list = JSON.parse(File.read(file))
	list.each_with_index do |item, i|
		# if i > 366
			puts i
			sleep(rand(9.0..13.0))
			begin 
				page = open_uri(base_url + item["url"]+"?#{rand(10..100000)}")
				File.open(path_to_file, "a+") do |f|
					f.write(get_product(page, item["taxon_id"]).to_json)
				end
			rescue => e
				puts "#{e}"
			end
		# end
	end
end 

def get_product(page, taxon_id)
	product_name = page.css(".zagl h1").text
	product_code = page.css(".leftsubcol li").first.css(".property_value").text
	product_brand = page.css(".leftsubcol li")[1].css(".property_value").text
	product_price = page.css(".price .newprice").text 
	product_price = product_price.gsub(" ","").to_i
	product_properties = page.css(".zebragroup1 .props_group li").map{|a| {:key => a.css(".name").text.strip, :value => a.css(".value").text.strip}}
	product_description = page.css(".detail_text").empty? ?  " " : page.css(".detail_text p").text
	product_complect_codes = page.css(".cmplopis1_art").text.strip.squish.gsub("Код товара: ","").split(" ").map{|a| a.to_i}
	product_images = page.css("#basic-modal li a").map{|a| a.attr("href").split("/")}
	product_imgs = []
	product_images.each do |image|
		image.delete_at(2)
		image.delete_at(4)
		image = "http://santehnika-online.ru/" + image.join("/")
		product_imgs << image
	end
	#puts "#{product_imgs}"
	product = {:name => product_name, :description => product_description, :code => product_code, 
	:price => product_price, :properties => product_properties, :complect_codes => product_complect_codes,
	:images => product_imgs, :taxon_id => taxon_id, :brand => product_brand}
	return product
end

def open_uri(uri)
	puts "#{uri}"
	Nokogiri::HTML(open(uri))
end

# def build_uri(uri_array, page=nil)
# 	@limit = 108
# 	@base_uri = "http://santehnika-online.ru/"
# 	uri = "#{@base_uri}/#{uri_array}?perpage=#{@limit}"
# 	uri += page ? "&PAGEN_1=#{page}" : ""
# 	uri
# end

# def get_max_page(page)
# 	doc = open_uri(build_uri(page))
# 	puts doc.css(".paginator a").map{|a| a.text.to_i}
# 	pg = doc.css(".paginator a").map{|a| a.text.to_i}.max || 1 
# end	

# def get_items_links(page)
# 	links = []
# 	@max = get_max_page(page)
# 	(1..@max).each do |x|
# 		puts "starting #{x} of #{@max}"
# 		links.concat get_css_list(build_uri(page, x), '.product .photo a')
# 		puts links.uniq.size
# 		sleep(10.0)
# 	end
# 	puts links.size
# 	links
# end

# def get_css_list(uri, css_selector, attrib = "href")
# 	items = []
# 	open_uri(uri).css(css_selector).each{ |i| items.push i[attrib] }
# 	items
# end