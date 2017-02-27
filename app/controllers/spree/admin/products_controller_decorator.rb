Spree::Admin::ProductsController.class_eval do
	def update
		if params[:product][:taxon_ids].present?
          params[:product][:taxon_ids] = params[:product][:taxon_ids].split(',')
        end
        if params[:product][:option_type_ids].present?
          params[:product][:option_type_ids] = params[:product][:option_type_ids].split(',')
        end
       
        invoke_callbacks(:update, :before)
        if @object.update_attributes(permitted_resource_params)
          invoke_callbacks(:update, :after)
          flash[:success] = flash_message_for(@object, :successfully_updated)
          	if params[:product][:from_index].present?
          		logger.debug("12332123123123---------------")
          		logger.debug(collection)
	          	if params[:product][:available_on].present?
		        	params[:product][:available_on] = params[:product][:available_on] == "0" ?  "" : Time.current 
		        end
		        @collection = collection
		        logger.debug(@collection)
	          	@object.update_attributes(:available_on => params[:product][:available_on])
	          	respond_with(@collection) do |format|
		            format.html { redirect_to  :back }
		            format.js   { render layout: false }
		        end
          	else
		        respond_with(@object) do |format|
		            format.html { redirect_to location_after_save }
		            format.js   { render layout: false }
		        end
	      	end
        else
          # Stops people submitting blank slugs, causing errors when they try to
          # update the product again
          @product.slug = @product.slug_was if @product.slug.blank?
          invoke_callbacks(:update, :fails)
          respond_with(@object)
        end
	end
end