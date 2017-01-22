task :image_parser do 
	files = ["Биде","Водонагреватели","Ванны из искусственного камня","Диспоузеры (измельчители)",
		"Душевые боксы","Душевые кабины","Душ", "Инсталляции","Кухонные мойки","Люки сантехнические",
		"Писсуары", "Полотенцесушители","Раковины","Сифоны","Стальные ванны",
		"Теплые полы","Трапы, душевые лотки","Унитазы","Сифоны", "Чугунные ванны"]
		h = Rails.root.to_s + "/public/image_links/"
		f = Rails.root.to_s + "/public/product_list/"
		files.each do |file|
			page = f+file+".json"
			ff = JSON.parse(File.read(page))
			images = []
			ff.map{|i| images << i['images'].first && images << i["images"].last}.flatten.uniq.compact
			images = images.uniq.compact.map{|a| [a, a.split("/").last]}
			puts images.size
			File.open(h+file+".txt", "w+") do |f| 
				f.write(images) 
			end
		end 
end
