Spree::Admin::ProductsController.class_eval do
	def update
		if params[:product][:taxon_ids].present?
          params[:product][:taxon_ids] = params[:product][:taxon_ids].split(',')
        end
        if params[:product][:option_type_ids].present?
          params[:product][:option_type_ids] = params[:product][:option_type_ids].split(',')
        end
        if params[:product][:from_index].present?
	          	if params[:product][:available_on].present?
		        	params[:product][:available_on] = params[:product][:available_on] == "0" ?  "" : Time.current 
		        end
		        if @object.sku == "" || @object.sku.nil? 
		        	last_sku = Spree::Variant.order("sku").last.sku
		        	curr_sku = last_sku == ""||last_sku.nil? ? "1".rjust(5, '0') : (last_sku.to_i+1).to_s.rjust(5, '0')
		        	params[:product][:sku] = curr_sku
		        end 
		end
        invoke_callbacks(:update, :before)
        if @object.update_attributes(permitted_resource_params)
          invoke_callbacks(:update, :after)
          flash[:success] = flash_message_for(@object, :successfully_updated)
          	if params[:product][:from_index].present?
		        @collection = collection
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
          	@product.slug = @product.slug_was if @product.slug.blank?
          	invoke_callbacks(:update, :fails)
          	respond_with(@object)
        end
	end
end