$('document').ready(function(){
	$('.price-add-to-cart').on('click','.add_to_cart_button',function(){
	    variant_id = $(this).attr('data-link').split('-')[1];
	    url = '/orders/populate';
	    quantity = 1;
	    $.post( url, {
		  	variant_id: variant_id,
		    quantity: quantity
		}
		);
	});
});