$(".pw-reset-submit").on('click tap touch',function() {
    var pass = $("#reg-pass").val();
    var confpass = $("#reg-confpass").val();
    $.ajax({
        type:'POST',
        url:'/setpw',
        data:'&password='+pass+'&confpass='+confpass+'&check=1',
        success:function (res) {
        if (res != 'password reseted successfully'){
            var error = res;
            var e=0;
            var erroeFaildes=["password-error","confpass-error"]
            for (e=0;e<erroeFaildes.length;e++){
                $("#"+erroeFaildes[e]).html("");
            }
            error=error.split(": ");
            $("#"+error[0]+"-error").html(error[1]);
        }
        else{
            $(".pw-reset-form").submit()
        }
    }
       });
    return false; 
});