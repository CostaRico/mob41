class CallMessagesController < ApplicationController
	def create
		@flag = false
		@call_message = CallMessage.new(params[:call_message])
			if verify_recaptcha(model: @call_message) && @call_message.save
			  	@flag = true
			else
				@flag= false
			end
		respond_to do |format|
			format.js 
		end
	end
	def index
		render json: {:ala => "asdasdasd"}
	end
	private
	  def call_message_params
	    params.require(:call_message).permit([:name, :phone, :message])
	  end
end