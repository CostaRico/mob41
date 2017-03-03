Spree::TaxonsController.class_eval do 

	  helper_method :sorting_param
    alias_method :old_show, :show

    def show
      old_show
      # @taxon = Spree::Taxon.friendly.find(params[:id])
      # return unless @taxon
      # @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
      # # @products = @products.reorder('').send(sorting_scope) if params[:sorting].present?
      # @taxonomies = Spree::Taxonomy.includes(root: :children)
      @min_product_price = Spree::Price.order(:amount).first.amount.to_i
      @max_product_price = Spree::Price.order(:amount).last.amount.to_i
      @products = @products.master_price_lte(params[:max_price].to_f) if params[:max_price]&&!params[:max_price].blank?
      @products = @products.master_price_gte(params[:min_price].to_f) if params[:min_price]&&!params[:min_price].blank? #if params.key?(:minprice) @&& params.key?(:maxprice)
    end

    def sorting_param
      params[:sorting].try(:to_sym) || default_sorting
    end

    
    private

    def sorting_scope
      allowed_sortings.include?(sorting_param) ? sorting_param : default_sorting
    end

    def default_sorting
      :ascend_by_updated_at
    end

    def allowed_sortings
      [:descend_by_master_price, :ascend_by_master_price, :ascend_by_updated_at]
    end

    # def base_scope_c(taxon)
    #   base_scope = Spree::Product.spree_base_scopes.active
    #   base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
    #   base_scope = get_products_conditions_for(base_scope, keywords)
    #   base_scope = add_search_scopes(base_scope)
    #   base_scope = add_eagerload_scopes(base_scope)
    #   base_scope
    # end
            

end