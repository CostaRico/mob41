# encoding: utf-8
Spree::Taxon.class_eval do

  def applicable_filters
    fs = []
	# case self.name
	#    when "Биде" 
	   	
	#    end   
    #fs << Spree::Core::ProductFilters.select_type_any(self) if Spree::Core::ProductFilters.respond_to?(:select_type_any)
    #fs << Spree::Core::ProductFilters.price_filter if Spree::Core::ProductFilters.respond_to?(:price_filter)
    fs << Spree::Core::ProductFilters.select_dev_any(self) if Spree::Core::ProductFilters.respond_to?(:select_dev_any)
    fs << Spree::Core::ProductFilters.select_country_any(self) if Spree::Core::ProductFilters.respond_to?(:select_country_any)
    fs << Spree::Core::ProductFilters.select_material_any(self) if Spree::Core::ProductFilters.respond_to?(:select_material_any)
    fs << Spree::Core::ProductFilters.select_forms_any(self) if Spree::Core::ProductFilters.respond_to?(:select_forms_any)
    fs << Spree::Core::ProductFilters.select_montaj_any(self) if Spree::Core::ProductFilters.respond_to?(:select_montaj_any)
    fs << Spree::Core::ProductFilters.select_napolnoe_any(self) if Spree::Core::ProductFilters.respond_to?(:select_napolnoe_any)
    fs << Spree::Core::ProductFilters.select_nastennoe_any(self) if Spree::Core::ProductFilters.respond_to?(:select_nastennoe_any)
    fs << Spree::Core::ProductFilters.select_color_any(self) if Spree::Core::ProductFilters.respond_to?(:select_color_any)
    fs << Spree::Core::ProductFilters.select_width_any(self) if Spree::Core::ProductFilters.respond_to?(:select_width_any)
    fs << Spree::Core::ProductFilters.select_deep_any(self) if Spree::Core::ProductFilters.respond_to?(:select_deep_any)
    fs << Spree::Core::ProductFilters.select_height_any(self) if Spree::Core::ProductFilters.respond_to?(:select_height_any)
    fs << Spree::Core::ProductFilters.select_out_look_any(self) if Spree::Core::ProductFilters.respond_to?(:select_out_look_any)
    fs << Spree::Core::ProductFilters.select_door_for_any(self) if Spree::Core::ProductFilters.respond_to?(:select_door_for_any)
    fs << Spree::Core::ProductFilters.select_cap_in_any(self) if Spree::Core::ProductFilters.respond_to?(:select_cap_in_any)
    fs << Spree::Core::ProductFilters.select_seed_in_any(self) if Spree::Core::ProductFilters.respond_to?(:select_seed_in_any)
    fs << Spree::Core::ProductFilters.select_mix_in_any(self) if Spree::Core::ProductFilters.respond_to?(:select_mix_in_any)
    fs << Spree::Core::ProductFilters.select_guarantee_any(self) if Spree::Core::ProductFilters.respond_to?(:select_guarantee_any)
    
    #fs << Spree::Core::ProductFilters.select_type_any(self) if Spree::Core::ProductFilters.respond_to?(:select_type_any)

    fs
  end


  	
end