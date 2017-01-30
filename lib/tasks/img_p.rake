task :image_parser do 
	#files = ["Биде","Водонагреватели","Ванны из искусственного камня","Диспоузеры (измельчители)",
	#	"Душевые боксы","Душевые кабины","Душ", "Инсталляции","Кухонные мойки","Люки сантехнические",
	#	"Писсуары", "Полотенцесушители","Раковины","Сифоны","Стальные ванны",
	#	"Теплые полы","Трапы, душевые лотки","Унитазы","Сифоны", "Чугунные ванны","Уголки, ограждения, поддоны","Уголки, ограждения, поддоны_1"]
	files = ["products_list_3"]
		h = Rails.root.to_s + "/public/image_links/"
		f = Rails.root.to_s + "/public/product_list/"
		files.each do |file|
			page = f+file+".json"
			ff = JSON.parse((eval(File.read(page))).to_json)
			images = []
			ff.map{|i| images << i['images'].first && images << i["images"].last}.flatten.uniq.compact
			images = images.uniq.compact.map{|a| [a, a.split("/").last]}
			images = images.map{|a| [a[0] = a[0].split("/iblock").size > 1 ? a[0] : a[0].gsub("upload", "upload/iblock"), a[1]]}
			puts images.size
			File.open(h+file+".txt", "w+") do |f| 
				f.write(images) 
			end
		end 
end
