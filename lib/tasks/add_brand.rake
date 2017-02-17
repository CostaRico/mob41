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
# ["Vegas Glass", "GuteWetter", "Sturm", "Migliore", "IFO", "RGW", 
# 	"Rav Slezak", "Damixa", "Jacob Delafon", "Grohe", "Nicolazzi", 
# 	"Cezares", "Timo", "Vidima", "Roca", "Laufen", "Bravat", 
# 	"Opadiris", "Oras", "Keuco", "De Dietrich", "Lemark", "Devon&Devon", 
# 	"Fixsen", "Am.Pm", "Ideal Standard", "Viega", "Fiore", "Ravak", "Cersanit", 
# 	"De Aqua", "Geberit", "Kludi", "SMARTsant", "Giulini", "Toto", 
# 	"Tiffany World", "Duravit", "OLI", "Jika", "AlcaPlast", "Gllon", 
# 	"Edelform", "VitrA", "Bossini", "Nobili", "Villeroy & Boch", 
# 	"Caprigo", "Labor Legno", "GPD", "Aquanet", "TECE", "Galassia", 
# 	"Kerasan", "BelBagno", "Aqwella 5 stars", "Dreja", "Aqwella", 
# 	"Атолл", "Belux", "La Beaute", "Gemelli", "Misty", "La Beaute Classic", 
# 	"Bellezza", "Fima Carlo Frattini", "Бриклаер", "Акватон", "Triton", 
# 	"Olympia", "Eban", "Serel", "Onika", "Aqualife Design", "Treemme", 
# 	"Gattoni", "Inova", "Hansgrohe", "Novellini", "Angleter", "Berloni Bagno", 
# 	"Clarberg", "Eurolegno", "Huppe", "Evoform", "TOURBILLON", "River", "Merkana", 
# 	"ASB-Mebel", "Mariani", "FBS", "Nautico", "Primus", "Catalano", "ArtCeram", 
# 	"Globo", "Rosa", "Simas", "Newform", "Colombo Design", "Франция", "СанТа", 
# 	"Romance Collection", "Koh-i-Noor", "Demax", "Iside", "Santek", "Sanita luxe", 
# 	"Hatria", "GSI", "Hidra Ceramica", "Appollo", "Zehnder", "Disegno Ceramica", 
# 	"Tera", "Ника", "Bas", "1MarKa", "Gala", "Warmstad", "Теплолюкс", "Orans", "Аквалайф", 
# 	"Azzurra", "Dreja.eco", "E.C.A", "Stiebel Eltron", "Vigo", "Двин", "Стилье", "Valentin", 
# 	"Grota", "TermoSmart", "Irsap", "Margaroli", "Bien", "Gustavsberg", "Bagno & Associati", 
# 	"Thermo", "Caleo", "Riho", "Sanplast", "Aura Technology", "Olive'S", "Kraus", "Rossinka", 
# 	"Hajdu", "Energy", "Radaway", "Rush", "Alpen", "Della", "Оскольская керамика", "Santeri", 
# 	"Arcus", "Kolpa San", "Althea ceramica", "Keramag", "Recor", "Kaldewei", "Devi", "Electrolux", 
# 	"AEG", "InSinkErator", "Rehau", "KoreaStar", "Raychem", "Runo", "Buderus", "Garcia", "Pelipal", 
# 	"BLB", "LVI", "Сунержа", "Creavit", "Imex", "Castalia", "Elegansa", "Luxus", "Thermex", 
# 	"Viessmann", "ESSE", "Zorg", "Seaman", "Aqualux", "Axa", "Niagara", "ВИЗ", "Bette", 
# 	"ACV", "Terminus", "Tehnolit", "Gorenje", "Bone Crusher", "Status", "Franke", 
# 	"Revizor", "Harte", "Rerih", "Hemstedt", "Parly", "Vaillant", "Nibe", "Drazice", 
# 	"Baxi", "Ariston", "Lagard", "D&K", "IQ Watt", "Cordivari", "Zanussi", "Vagnerplast", 
# 	"Эван", "Victoria+Alber", "Blanco", "Orange", "Aqua Joy", "Opoczno", "Pestan", 
# 	"Ulgran", "Protherm", "Superlux", "GranFest", "Reginox", "Rodi", "Florentina", 
# 	"Oulin", "Whinstone", "Fresh", "Schock", "Atlantic", "Ладогаз", "Omoikiri", "Portu", 
# 	"Steel Hammer", "Lava", "Хаммер", "Люкер", "Stout", "Alveus", "Mixline", "General Hydraulic", 
# 	"Lapesa", "Практика", "SFA", "Ballu", "Mauersberger", "Massimo", "Excellent", "Фэма", "Астра-Форм", 
# 	"Gemy", "Victory Spa", "Акватек", "Радомир", "Gruppo Treesse", "Аквафор", "Bach", "Atoll", "Bolu", 
# 	"Гейзер", "IDO", "Jacuzzi", "Svedbergs", "Esbano", "Барьер", "Teuco", "Новая Вода", "Eago", "Grande Home", "Home"]