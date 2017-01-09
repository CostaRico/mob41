$('document').ready(function(){
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

	$('.price-add-to-cart').on('click','.add_to_cart_button',function(){
      variant_id = $(this).attr('data-link').split('-')[1];
      url = '/orders/populate';
      quantity = 1;
      $.post( url, {
        variant_id: variant_id,
        quantity: quantity
     });
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
  	$(".quantity.buttons_added").on("click", ".plus", function(){
	  v = $(this).parent().children(".qty").val();
	  $(this).parent().children(".qty").val(++v);

	});
	$(".quantity.buttons_added").on("click", ".minus", function(){
	  v = $(this).parent().children(".qty").val();
	  $(this).parent().children(".qty").val(--v);

	});
	if($('#content-home').hasClass('home-page')){ 
       $(".departments-menu .nav-item.dropdown").addClass(" open");
       $(".departments-menu .nav-link.dropdown-toggle").attr("aria-expanded", true);
    };
    $('.dropdown-toggle').dropdownHover();
});
