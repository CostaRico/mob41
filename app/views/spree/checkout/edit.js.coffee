partial = "<%=j render :partial => 'form_wrapper', :format => :html, :locals => { :state => @order.state, :order => @order } %>"
step = ($ '#checkout_<%= @order.state %>')
error = "<%= flash[:error] %>"

replace_checkout_step(step, partial, error)

if step != "confirm"
	$('#checkout-summary').empty().append("<%= j render :partial => 'summary', :locals => { :order => @order } %>")