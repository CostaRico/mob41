#encoding: utf-8
module Spree
  module Admin
    class CallMessagesController < Spree::Admin::BaseController
    	def index
    		@call_messages = Spree::CallMessage.order("id DESC")
    	end

    	def destroy
    		@call_message =  Spree::CallMessage.find_by_id(params[:id])
    		if @call_message.destroy
            	flash[:success] = "Сообщение удалено"
		    else
		        flash[:error] = "Возникла ошибка при удалении сообщения"
		    end
    		respond_to do |format|
    			format.html {redirect_to admin_call_messages_path}
    		end
    	end
    end
  end
end