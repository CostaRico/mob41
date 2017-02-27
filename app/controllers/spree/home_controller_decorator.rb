Spree::HomeController.class_eval do 
	def index
		@searcher = build_searcher(params.merge(include_images: true))
	    @products = @searcher.retrieve_products
	    @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
	    @taxonomies = Spree::Taxonomy.includes(root: :children)
		@feat_products = Spree::Product.offset(rand(Spree::Product.count)).limit(6)
		@text_first_leg = Spree::Page.find_by_slug("/home-page-first-part")
		@text_second_leg = Spree::Page.find_by_slug("/home-page-second-part")
	end
end