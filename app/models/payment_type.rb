class PaymentType < ActiveRecord::Base
	has_many :spree_addresses
end