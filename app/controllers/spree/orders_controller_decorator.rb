Spree::OrdersController.class_eval do
	def populate
      order    = current_order(create_order_if_necessary: true)
      variant  = Spree::Variant.find(params[:variant_id].to_i)
      quantity = params[:quantity].to_i
      options  = params[:options] || {}

      # 2,147,483,647 is crazy. See issue #2695.
      if quantity.between?(1, 2_147_483_647)
        begin
          order.contents.add(variant, quantity, options)
        rescue ActiveRecord::RecordInvalid => e
          error = e.record.errors.full_messages.join(", ")
        end
      else
        error = Spree.t(:please_enter_reasonable_quantity)
      end

      if error
        flash[:error] = error
        redirect_back_or_default(spree.root_path)
      else
       	if request.xhr?
	    	respond_to do |format|
	    		format.js
	    	end
	     else    
	        respond_with(order) do |format|
	          format.html { redirect_to cart_path }
	         end
	     end
      end
    end

    def remove_line_item
    	if request.xhr?
        # @tr = Thread.new { 
  	    	@order = current_order
  	    	quantity = 0
  	    	line_item = params[:item].split("_").last.to_i
  	    	item = {:line_items_attributes => {:id => line_item, :quantity => quantity}}
  	    	@order.contents.update_cart(item)
        # }
        # at_exit{@tr.join}
	    	respond_to do |format|
		    	format.js
		    end
		end
    end
end 
