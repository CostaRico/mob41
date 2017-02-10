class DeliveryType < ActiveRecord::Base
	has_many :spree_addresses
end