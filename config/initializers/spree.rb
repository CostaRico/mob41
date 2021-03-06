
# require "#{Rails.root}/lib/spree/custom_search"
# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
require "#{Rails.root}/lib/spree/product_filters"
require "#{Rails.root}/lib/spree/custom_search"
Spree::Config.searcher_class = Spree::CustomSearch
Spree::Auth::Config[:registration_step] = false;
Spree::Auth::Config[:confirmable] = false
Spree.config do |config|

  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
  # config.currency = 'RUB'
end

  # require 'spree/core/product_filters'

Spree::PermittedAttributes.address_attributes << :comment
Spree::PermittedAttributes.address_attributes << :delivery_type_id
Spree::PermittedAttributes.address_attributes << :payment_type_id
Spree::PermittedAttributes.product_attributes << :provider_id
Spree::PermittedAttributes.product_attributes << :provider_price
Spree::Config[:layout]='spree/layouts/spree_application'
Spree.user_class = "Spree::User"

