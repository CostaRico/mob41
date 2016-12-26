Spree::Taxon.class_eval do

  def applicable_filters
    fs = []

    #fs << Spree::Core::ProductFilters.price_filter if Spree::Core::ProductFilters.respond_to?(:price_filter)
    fs << Spree::Core::ProductFilters.selective_country_filter(self) if Spree::Core::ProductFilters.respond_to?(:selective_country_filter)
    fs
  end



end