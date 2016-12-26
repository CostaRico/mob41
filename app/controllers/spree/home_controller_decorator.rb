Spree::HomeController.class_eval do 
	def index
		@searcher = build_searcher(params.merge(include_images: true))
	    @products = @searcher.retrieve_products
	    @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
	    @taxonomies = Spree::Taxonomy.includes(root: :children)
		@feat_products = Spree::Product.first(12)
	end
end