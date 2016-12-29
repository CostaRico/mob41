Spree::TaxonsController.class_eval do 
	def show
      @taxon = Spree::Taxon.friendly.find(params[:id])
      return unless @taxon

      @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))

      
      @taxonomies = Spree::Taxonomy.includes(root: :children)
      @products = @searcher.retrieve_products#.send(:ascend_by_master_price)
      # logger.debug("#{@products.order('name ASC')}")
      if request.xhr? && params[:order_by]
          @products = case params[:order_by]
            when "name"
              @products.send(:ascend_by_name)
            when "name-desc"
              @products.send(:descend_by_name)
            when "price"
              @products.send(:ascend_by_master_price)
            when "price-desc"
               @products.send(:descend_by_master_price)
            else
              @products  
            end
		      	# session[:location] = params[:value]
            respond_to do |format|
              format.js
            # render :js => "window.location = '#{nested_taxons_path(@taxon)}'?order_by=#{params[:order_by]}"
		        end
		  end
	end

    def sort_by(param)
    	param.split("_")[0] + " " + param.split("_")[1].upcase
    end
    private

    def default_sorting
      :ascend_by_name
    end

    def allowed_sortings
      [:descend_by_master_price, :ascend_by_master_price, :ascend_name, :descend_by_name]
    end
end