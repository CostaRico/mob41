$(document).ready -> 
	order_use_billing = ($ 'input#order_use_billing')
	order_use_billing.change ->
		update_shipping_form_state = (order_use_billing) ->
			if order_use_billing.is(':checked')
				($ '.shipping-fields').hide()
				($ '.shipping-fields select').prop 'disabled', true
			else
				($ '.shipping-fields').show()
				($ '.shipping-fields select').prop 'disabled', false
				Spree.updateState('s')
		update_shipping_form_state order_use_billing