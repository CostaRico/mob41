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