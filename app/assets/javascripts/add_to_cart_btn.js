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
