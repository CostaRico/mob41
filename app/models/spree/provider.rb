module Spree
	class Provider < ActiveRecord::Base
		has_many :spree_products

		def self.active_providers
			where(:active => true)			
		end
	end 
end