String.prototype.format = function () {
    var i = 0, args = arguments;
    return this.replace(/{}/g, function () {
        return typeof args[i] != 'undefined' ? args[i++] : '';
    });
};



function setErrors(errors) {
    $('.errors').empty();
    
    $('#title-error').html(errors.title);
    $('#price-error').html(errors.price);
    $('#order-error').html(errors.order);
    $('#image-error').html(errors.image);
    return false;
}



function setProducts() {
    $('.cards-holder').empty();

    card_str=`
    <div class="cell main-aa-center base-30-lg base-50-md base-100-sm">
        <div class="card">
            <div class="my-col card-col">
                <div class="my-row main-aa-sp-bt base-10-sm">
                    <div class="cell flexable-x base-50-sm">
                        <h1>{}</h1>
                    </div>
                    <div class="cell flexable-x base-50-sm">
                        <button mod_id='{}' class="modify-card self-align-end"><i class="fas fa-cogs modify-card-icon"></i></button>
                    </div>
                </div>
                <div class="my-row base-40-sm">
                    <div class="cell base-100-sm">
                        <img src="/local/products_images/{}" alt="">
                    </div>
                </div>
                <div class="my-row base-40-sm">
                    <div class="cell base-100-sm">
                        <div class="card-text">
                            <h1>{}</h1>
                            <p class="card-desc">{}</p>
                        </div>
                    </div>
                </div>
                <div class="my-row base-10-sm">
                    <div class="cell main-aa-end cross-aa-end base-100-sm">
                        <p class="card-price">{} $</p> 
                    </div>
                </div>
            </div>
        </div>
    </div>
    `
    
    $.ajax({
        type:'POST',
        url:'/home-man-get-products',
        success:function (res) {
            var c=0;
            for(c=0;c<res.length; c++){
                $(".cards-holder").append(card_str.format(res[c].order,res[c].id,res[c].image,res[c].title,res[c].description,res[c].price));
            }
        }
    });

}






$('.hidden').on('click tap touch',function() {
    $('.product-mod-window').css('display','none');
})

$(document).on( 'keydown', function(event) { 
    if (event.key == "Escape") { 
        $('.product-mod-window').css('display','none');
    } 
});


$('.cards-holder').on('click tap touch','.modify-card',function() {
    $(".id").val('');
    $("#h-man-title").val('');
    $("#h-man-order").val('');
    $("#h-man-price").val('');
    $("#h-man-discription").val('');

    $.ajax({
        type:'POST',
        url:'/home-man-mod-products',
        data: {id:$(this).attr("mod_id"), mode:'0'},
        success:function (res) {
            var c=0;
            for(c=0;c<res.length; c++){
                $(".id").val(res[c].id);
                $("#h-man-title").val(res[c].title);
                $("#h-man-order").val(res[c].order);
                $("#h-man-price").val(res[c].price);
                $("#h-man-discription").val(res[c].description);
                $('.errors').empty();
                $('.product-mod-window').css('display','block');
                $('.ap').css('display','none');
                $('.ac').css('display','block');
                $('.dp').css('display','block');
            }
        }
    });
})

$('.add-product').on('click tap touch',function() {
    $(".id").val();
    $("#h-man-title").val('');
    $("#h-man-order").val('');
    $("#h-man-price").val('');
    $("#h-man-discription").val('');
    $('.errors').empty();
    $('.product-mod-window').css('display','block');
    $('.ap').css('display','block');
    $('.ac').css('display','none');
    $('.dp').css('display','none');
})



$('.ap').on('click tap touch',function() {
    $('.product-mod-window').css('display','none');
    $('.loading-screen').css('display','block');

    var id = $(".id").val();
    var title = $("#h-man-title").val();
    var order = $("#h-man-order").val();
    var price = $("#h-man-price").val();
    var discription = $("#h-man-discription").val();
    try{
        var image = $("#h-man-image").prop('files')[0];
        var image_name = $("#h-man-image").prop('files')[0].name;
        var reader = new FileReader();
        reader.onload = function(e) {
            imageData=btoa(e.target.result);
            $.ajax({
                type:'POST',
                url:'/home-man-ap',
                data:{id:id, title:title, price:price, discription:discription, image:imageData, imagename:image_name, order:order},
                success:function (res) {
                    if (res !="OK"){
                        setErrors(res);
                        $('.loading-screen').css('display','none');
                        $('.fail-screen').css('display','block');
                        setTimeout(function(){
                            $('.fail-screen').css('display','none');
                            $('.product-mod-window').css('display','block');
                        }, 1000);
                    }
                    else{
                        $('.product-mod-window').css('display','none');
                        $('.loading-screen').css('display','none');
                        $('.success-screen').css('display','block');
                        setTimeout(function(){
                            $('.success-screen').css('display','none');
                            setProducts();
                        }, 1000);
                    }
                }
            });
        };
        reader.onerror = function(e) {
            console.log('Error : ' + e.type);
        };
        reader.readAsBinaryString(image);
    }
    catch(err){
        $.ajax({
            type:'POST',
            url:'/home-man-ap',
            data:{id:id, title:title, price:price, discription:discription, image:'', imagename:'', order:order},
            success:function (res) {
                if (res !="OK"){
                    setErrors(res);
                    $('.loading-screen').css('display','none');
                    $('.fail-screen').css('display','block');
                    setTimeout(function(){
                        $('.fail-screen').css('display','none');
                        $('.product-mod-window').css('display','block');
                    }, 1000);
                }
                else{
                    $('.product-mod-window').css('display','none');
                    $('.loading-screen').css('display','none');
                    $('.success-screen').css('display','block');
                    setTimeout(function(){
                        $('.success-screen').css('display','none');
                        setProducts();
                    }, 1000);
                }
            }
        });
    }
    return false; 
})









$('.ac').on('click tap touch',function() {
    $('.product-mod-window').css('display','none');
    $('.loading-screen').css('display','block');

    var id = $(".id").val();
    var title = $("#h-man-title").val();
    var order = $("#h-man-order").val();
    var price = $("#h-man-price").val();
    var discription = $("#h-man-discription").val();
    try {
        var image = $("#h-man-image").prop('files')[0];
        var image_name = $("#h-man-image").prop('files')[0].name;
        var reader = new FileReader();
        reader.onload = function(e) {
            imageData=btoa(e.target.result);
            $.ajax({
                type:'POST',
                url:'/home-man-mod-products',
                data:{id:id, title:title, price:price, discription:discription, image:imageData, imagename:image_name, order:order, mode:'1'},
                success:function (res) {
                    if (res !="OK"){
                        setErrors(res);
                        $('.loading-screen').css('display','none');
                        $('.fail-screen').css('display','block');
                        setTimeout(function(){
                            $('.fail-screen').css('display','none');
                            $('.product-mod-window').css('display','block');
                        }, 1000);
                    }
                    else{
                        $('.product-mod-window').css('display','none');
                        $('.loading-screen').css('display','none');
                        $('.success-screen').css('display','block');
                        setTimeout(function(){
                            $('.success-screen').css('display','none');
                            setProducts();
                        }, 1000);
                    }
                }
            });
        };
        reader.onerror = function(e) {
            console.log('Error : ' + e.type);
        };
        reader.readAsBinaryString(image);
    }
    catch(err) {
        $.ajax({
            type:'POST',
            url:'/home-man-mod-products',
            data:{id:id, title:title, price:price, discription:discription, image:'', imagename:'', order:order, mode:'1'},
            success:function (res) {
                if (res !="OK"){
                    setErrors(res);
                    $('.loading-screen').css('display','none');
                    $('.fail-screen').css('display','block');
                    setTimeout(function(){
                        $('.fail-screen').css('display','none');
                        $('.product-mod-window').css('display','block');
                    }, 1000);
                }
                else{
                    $('.product-mod-window').css('display','none');
                    $('.loading-screen').css('display','none');
                    $('.success-screen').css('display','block');
                    setTimeout(function(){
                        $('.success-screen').css('display','none');
                        setProducts();
                    }, 1000);
                }
            }
        });
    }

    
    return false; 
})




$('.dp').on('click tap touch',function() {
    $('.product-mod-window').css('display','none');
    $('.loading-screen').css('display','block');
    var id = $(".id").val();
    $.ajax({
        type:'POST',
        url:'/home-man-mod-products',
        data:{id:id, mode:'2'},
        success:function (res) {
            if (res !="OK"){
                $('.loading-screen').css('display','none');
                $('.fail-screen').css('display','block');
                setTimeout(function(){
                    $('.fail-screen').css('display','none');
                    $('.product-mod-window').css('display','block');
                }, 1000);
            }
            else{
                $('.product-mod-window').css('display','none');
                $('.loading-screen').css('display','none');
                $('.success-screen').css('display','block');
                setTimeout(function(){
                    $('.success-screen').css('display','none');
                    setProducts();
                }, 1000);
            }
        }
    });

    return false; 
})




setProducts();



