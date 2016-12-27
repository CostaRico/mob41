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
	$('.mini_cart_item').on('click','.remove',function(){
	    item = $(this).attr('id');
	    url = '/orders/remove_item';
	    quantity = 1;
	    $.post( url, {
		  	item: item
		}
		);
        $(this).parent().remove();
	});
	$( ".departments-menu" ).on( "click",'.nav-item' ,function() {
	  if ($(this).children(".nav-link").attr("aria-expanded")=='false'){
	    $(this).addClass(" open");
	    $(this).children(".nav-link").attr("aria-expanded","true")
	  }else
	  { $(this).removeClass("open");
	    $(this).children(".nav-link").attr("aria-expanded","false")
	  }
	});
	$( ".navbar-mini-cart" ).on( "click", ".nav-item", function() {
   	 	if ($(this).children(".nav-link").attr("aria-expanded")=='false')
   	 	{
    			$(this).addClass("open");
    			$(this).children(".nav-link").attr("aria-expanded","true")
    		}
    		else
  		{ 
  			$(this).removeClass("open");
    			$(this).children(".nav-link").attr("aria-expanded","false")
    		}
  	});
});
