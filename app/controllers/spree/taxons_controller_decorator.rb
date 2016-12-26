Spree::TaxonsController.class_eval do 
	def show
      @taxon = Spree::Taxon.friendly.find(params[:id])
      return unless @taxon

      @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))

      
      @taxonomies = Spree::Taxonomy.includes(root: :children)
      @products = @searcher.retrieve_products#.send(:ascend_by_master_price)
      logger.debug("#{@products.order('name ASC')}")
      	if request.xhr?
	      	if params[:order_by]
	      		@products.ascend_by_master_price
		      	respond_to do |format| 
		      		format.js
		      	end
		    end
		end
	end

    def sort_by(param)
    	param.split("_")[0] + " " + param.split("_")[1].upcase
    end
end