#encoding: utf-8
Spree::BaseHelper.class_eval do 
  def breadcrumbs(taxon, product)
      return "" if current_page?("/") || taxon.nil?
      separator = content_tag(:span, content_tag(:i, " ",class: ["fa", "fa-angle-right"]), class: "delimiter")
      crumbs = [link_to(content_tag(:span, "Главная", itemprop: "name"), spree.root_path, itemprop: "url") + separator]

      if taxon
         # crumbs << taxon.ancestors.collect { |ancestor| link_to(content_tag(:span, ancestor.name, itemprop: "name"), seo_url(ancestor), itemprop: "url") + separator }
         crumbs << link_to(content_tag(:span, taxon.name, itemprop: "name"), seo_url(taxon), itemprop: "url") 
      else
        crumbs << content_tag(:span, Spree.t(:products), itemprop: "item")
      end
     
      #crumbs << separator + product.name  if product 

      crumb_list = raw(crumbs.flatten.map{|li| li.mb_chars}.join)
      content_tag(:nav, crumb_list, id: 'breadcrumbs', class: 'woocommerce-breadcrumb')
  end
  def checkout_progress(numbers: false)
      # compl_css = "padding: 0.465em 0.929em; background-color: #f5f5f5; border-radius: 0.357em"
      # current_css = "padding: 0.465em 0.929em;    background-color: #fed700; border-radius: 0.357em"
      states = @order.checkout_steps
      items = states.each_with_index.map do |state, i|
        text = Spree.t("order_state.#{state}").titleize
        text.prepend("#{i.succ}. ") if numbers

        css_classes = []
        current_index = states.index(@order.state)
        state_index = states.index(state)

        if state_index < current_index
          css_classes << 'complete_br'
          text = link_to text, checkout_state_path(state)
        end
        if state_index == current_index
          css_classes << "current_br"
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

    def display_price(product_or_variant)
      if product_or_variant.price.to_i == 0
        "Цена по запросу"
      else
        raw product_or_variant.
          price_in(current_currency).
          display_price_including_vat_for(current_price_options).
          to_html.split(",00").first+" руб."
      end
    end

    def taxons_tree(root_taxon, current_taxon, max_level = 1)
      return '' if max_level < 1 || root_taxon.leaf?
      content_tag :div, class: 'list-group' do
        taxons = root_taxon.children.map do |taxon|
          css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'list-group-item active' : 'list-group-item'
          link_to(taxon.name, seo_url(taxon), class: css_class) + taxons_tree(taxon, current_taxon, max_level - 1)
        end
        safe_join(taxons, "\n")
      end
    end

    def current_sorting?(key)
      sorting_param == key.to_sym
    end
    
    def cache_key_for_products
      count = @products.count
      first_id = @products.first.id
      sorting = params[:sorting]
      "#{I18n.locale}/#{current_currency}/spree/products/all-#{params[:page]}-#{first_id}-#{sorting}-#{count}"
    end
    def display_hum_price(price)
      ActionController::Base.helpers.number_with_delimiter(price.to_i, delimiter: " ")
    end

    def order_count(count)
      return count.to_i > 99 ? "99+" : count
    end
    
    def seo_url(taxon)
      return main_app.categories_path(taxon.permalink)
    end
end