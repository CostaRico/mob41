module Spree
	class CallMessagesController < Spree::StoreController
		def create
			@flag = false
			@call_message = Spree::CallMessage.new(params.require("call_message").permit(:id, :name, :phone, :comment))
				if verify_recaptcha(model: @call_message) && @call_message.save
				  	@flag = true
				else
					@flag = false
				end
			respond_to do |format|
				format.js
			end
		end
		private
		  # def call_message_params
		  #   params.require(:call_message).permit(:id, :name, :phone, :comment)
		  # end
	end
end