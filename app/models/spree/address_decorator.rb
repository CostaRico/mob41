module Spree
	Address.class_eval do 
	    def require_phone?
	      false
	    end

	    def require_zipcode?
	      false
	    end
	    _validators.reject!{ |key, value| key == :lastname || key == :firstname || key ==:address1 || key == :city || key ==:email }
	    _validate_callbacks.each do |callback|
	      callback.raw_filter.attributes.reject! { |key| key == :lastname || key == :firstname || key ==:address1 || key == :city || key ==:email} if callback.raw_filter.respond_to?(:attributes)
	    end
	    #validates :firstname, :lastname, :address1, :city, :zipcode, :country, :phone, :presence => false
	end
end