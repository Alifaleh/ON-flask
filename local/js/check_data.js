// ajax for registeration

$(".register-submit").on('click tap touch',function() {
    $(".register-submit").prop('disabled', true);
    var uname = $("#reg-uname").val();
    var email = $("#reg-email").val();
    var pass = $("#reg-pass").val();
    var confpass = $("#reg-confpass").val();
    $.ajax({
        type:'POST',
        url:'/checkdata',
        data:'username='+uname+'&email='+email+'&password='+pass+'&confpass='+confpass,
        success:function (res) {
        if (res != 'registered sucssessfuly'){
            res = res.substring(2, res.length-2);
            var errors = res.split("', '");
            var e=0;
            var erroeFaildes=["username-error","email-error","password-error","confpass-error"]
            for (e=0;e<erroeFaildes.length;e++){
                $("#"+erroeFaildes[e]).html("");
            }
            e=0;
            for (e=0;e<errors.length;e++){
                errors[e]=errors[e].split(": ");
            }
            e=0;
            for (e=0;e<errors.length;e++){
                $("#"+errors[e][0]+"-error").html(errors[e][1]);
            }
            $(".register-submit").prop('disabled', false);
        }
        else{
            $(".sign-up-form").submit();
        }
    }
       });
    return false; 
});



$(".reg-input").blur(function() {
    var toBeChecked=this.id;
    var value=$('#'+this.id).val();

    $.ajax({
        type:'POST',
        url:'/checkone',
        data:'tobechecked='+toBeChecked+'&value='+value,
        success:function (res) {
            var error = res;
            error=error.split(": ");
            $("#"+error[0]+"-error").html(error[1]);
        }
    });
});
    


// ajax for sign in

$(".sign-in-submit").on('click tap touch',function() {
    var uname = $("#sign-uname").val();
    var pass = $("#sign-pass").val();
    $.ajax({
        type:'POST',
        url:'/checklogindata',
        data:'username='+uname+'&password='+pass,
        success:function (res) {
        if (res != 'signed in sucssessfuly'){
            res = res.substring(2, res.length-2);
            var errors = res.split("', '");
            var e=0;
            var erroeFaildes=["password-error-l"]
            for (e=0;e<erroeFaildes.length;e++){
                $("#"+erroeFaildes[e]).html("");
            }
            e=0;
            for (e=0;e<errors.length;e++){
                errors[e]=errors[e].split(": ");
            }
            e=0;
            for (e=0;e<errors.length;e++){
                $("#"+errors[e][0]+"-error-l").html(errors[e][1]);
            }
        }
        else{
            $(".sign-in-form").submit()
        }
    }
       });
    return false; 
});
