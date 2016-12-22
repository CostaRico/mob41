Spree::BaseHelper.class_eval do 
  def breadcrumbs(taxon, product)
      return "" if current_page?("/") || taxon.nil?
      separator = content_tag(:span, content_tag(:i, " ",class: ["fa", "fa-angle-right"]), class: "delimiter")
      crumbs = [link_to(content_tag(:span, Spree.t(:home), itemprop: "name"), spree.root_path, itemprop: "url") + separator]

      if taxon
         crumbs << taxon.ancestors.collect { |ancestor| link_to(content_tag(:span, ancestor.name, itemprop: "name"), seo_url(ancestor), itemprop: "url") + separator }
         crumbs << link_to(content_tag(:span, taxon.name, itemprop: "name"), seo_url(taxon), itemprop: "url") 
      else
        crumbs << content_tag(:span, Spree.t(:products), itemprop: "item")
      end
     
      crumbs << separator + product.name  if product 

      crumb_list = raw(crumbs.flatten.map{|li| li.mb_chars}.join)
      content_tag(:nav, crumb_list, id: 'breadcrumbs', class: 'woocommerce-breadcrumb')
  end
end