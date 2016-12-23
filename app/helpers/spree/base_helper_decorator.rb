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
  def checkout_progress(numbers: false)
      states = @order.checkout_steps
      items = states.each_with_index.map do |state, i|
        text = Spree.t("order_state.#{state}").titleize
        text.prepend("#{i.succ}. ") if numbers

        css_classes = []
        current_index = states.index(@order.state)
        state_index = states.index(state)

        if state_index < current_index
          css_classes << 'completed'
          text = link_to text, checkout_state_path(state)
        end

        css_classes << 'next' if state_index == current_index + 1
        css_classes << 'active' if state == @order.state
        css_classes << 'first' if state_index == 0
        css_classes << 'last' if state_index == states.length - 1
        # No more joined classes. IE6 is not a target browser.
        # Hack: Stops <a> being wrapped round previous items twice.
        if state_index < current_index
          content_tag('span', text, class: css_classes.join(' '))
        else
          content_tag('span', content_tag('a', text), class: css_classes.join(' '))
        end
      end
      separator = content_tag(:span, content_tag(:i, " ",class: ["fa", "fa-angle-right"]), class: "delimiter")
      content_tag('span', raw(items.join(separator)), class: 'progress-bar', id: "checkout-step-#{@order.state}")
    end
end