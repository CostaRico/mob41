Spree::Taxon.class_eval do

  def applicable_filters
    fs = []

    # fs << Spree::Core::ProductFilters.price_filter if Spree::Core::ProductFilters.respond_to?(:price_filter)
    fs << Spree::Core::ProductFilters.select_country_any(self) if Spree::Core::ProductFilters.respond_to?(:select_country_any)
    fs
  end


  	
end