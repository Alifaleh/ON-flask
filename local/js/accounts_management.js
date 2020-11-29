String.prototype.format = function () {
    var i = 0, args = arguments;
    return this.replace(/{}/g, function () {
        return typeof args[i] != 'undefined' ? args[i++] : '';
    });
};

var users=[];
var userIndex=0;



function search() {
    var search = $(".search-input").val();
    $.ajax({
        type:'POST',
        url:'/search',
        data:'search='+search,
        success:function (res) {
            users=res.split('/***/');
            try {
                var c1=0;
                for (c1=0;c1<users.length;c1++){
                    users[c1]=users[c1].split("*///*");
                    users[c1][1]=users[c1][1].split('*//*');
                    users[c1][0]=users[c1][0].split('*/*');
                    users[c1][2]=users[c1][2].split('*/*');
                    users[c1][3]=users[c1][3].split('*/*');
                    var c2=0;
                    for (c2=0;c2<users[c1][1].length;c2++){
                        users[c1][1][c2]=users[c1][1][c2].split('*/*');
                    }
                }
            }catch (error) {
                $(".appending-div").empty();
                console.error('empty response');
                return false;
            }
            $(".appending-div").empty();
            var accountRow="<div class='account-row'><table><tr><td>{}</td><td><input class='btnv' name='{}' type='button' value='View'></td></tr></table></div>";
            var c1=0;
            for (c1=0;c1<users.length;c1++){
                $(".appending-div").append(accountRow.format(users[c1][0][0],users[c1][0][0]));
            }
        }
    });
    return false;
}


function setPopUpData(username) {
    var c1=0;
    for (c1=0;c1<users.length;c1++){
        if (users[c1][0][0]==username){
            break;
        }
    }
    userIndex=c1;
    $('.popup-window .id').val(users[c1][0][4]);
    $('.popup-window #man-uname').val(users[c1][0][0]);
    $('.popup-window #man-email').val(users[c1][0][1]);
    $(".input-select option").removeAttr("selected");
    $(".input-select option[value='"+users[c1][0][2]+"']").attr("selected","selected");
    $(".account-type option").removeAttr("selected");
    $(".account-type option[value='"+users[c1][0][3]+"']").attr("selected","selected");
    var sessionsRow="<tr><td>client: {} <br> date: {}</td><td><input type='checkbox' key='{}' class='session-cb'> delete</td></tr>";
    var c2=0;
    $(".sessions-table").empty();
    if (users[c1][1][0].length>1){
        $('#sessions-header').html('There are '+users[c1][1].length+' sessions');
        for (c2=0;c2<users[c1][1].length;c2++){
            $(".sessions-table").append(sessionsRow.format(users[c1][1][c2][0],users[c1][1][c2][2].split('.')[0]+' +'+users[c1][1][c2][2].split('+')[1],users[c1][1][c2][1]));
        }
    }
    else{
        $('#sessions-header').html('There are no sessions');
    }

    var prRow="<tr ><td>date: {}</td><td><input type='checkbox' key='{}' class='pr-cb'> delete</td></tr>"
    $(".pr-table").empty();
    if (users[c1][2].length>1){
        $(".pr-table").append(prRow.format(users[c1][2][1].split('.')[0]+' +'+users[c1][2][1].split('+')[1],users[c1][2][0]));
    }
    var evRow="<tr><td>date: {}</td><td><input type='checkbox' key='{}' class='ev-cb'> delete</td></tr>"
    $(".ev-table").empty();
    if (users[c1][3].length>1){
        $(".ev-table").append(evRow.format(users[c1][3][1].split('.')[0]+' +'+users[c1][3][1].split('+')[1],users[c1][3][0]));
    }

}


$(".search-input").keyup(function() {
    search();
})

$('.appending-div').on('click tap touch','.btnv',function() {
    var username=$(this).attr("name");
    $('.errors').empty();
    setPopUpData(username);
    $('.popup-window').css('display','block');
})

$('.hidden').on('click tap touch',function() {
    userIndex=-1;
    $('.popup-window').css('display','none');
})

$(document).on( 'keydown', function(event) { 
    if (event.key == "Escape") { 
        $('.popup-window').css('display','none');
    } 
});


$('.spr').on('click tap touch',function() {
    $('.popup-window').css('display','none');
    $('.loading-screen').css('display','block');
    $.ajax({
        type:'POST',
        url:'/forgetpwreciever',
        data:'email='+users[userIndex][0][1]+'&uname='+users[userIndex][0][0],
        success:function (res) {
            if (res=='1'){
                search();
                setTimeout(function(){
                    setPopUpData(users[userIndex][0][0]);
                    $('.loading-screen').css('display','none');
                    $('.success-screen').css('display','block');
                    setTimeout(function(){
                        $('.success-screen').css('display','none');
                        $('.popup-window').css('display','block');
                    }, 1000);
                }, 2000);
            }
            else{
                setPopUpData(users[userIndex][0][0]);
                $('#account_type-error').html(res.split(': ')[1]);
                $('.loading-screen').css('display','none');
                $('.fail-screen').css('display','block');
                setTimeout(function(){
                    $('.fail-screen').css('display','none');
                    $('.popup-window').css('display','block');
                }, 1000);
            }  
        }
    });
})

$('.sev').on('click tap touch',function() {
    $('.popup-window').css('display','none');
    $('.loading-screen').css('display','block');
    $.ajax({
        type:'POST',
        url:'/sendve',
        data:'username='+users[userIndex][0][0]+'&email='+users[userIndex][0][1],
        success:function (res) {
            if (res=='1'){
                search();
                setTimeout(function(){
                    setPopUpData(users[userIndex][0][0]);
                    $('.loading-screen').css('display','none');
                    $('.success-screen').css('display','block');
                    setTimeout(function(){
                        $('.success-screen').css('display','none');
                        $('.popup-window').css('display','block');
                    }, 1000);
                }, 2000);
            }
            else{
                setPopUpData(users[userIndex][0][0]);
                $('#account_type-error').html(res.split(': ')[1]);
                $('.loading-screen').css('display','none');
                $('.fail-screen').css('display','block');
                setTimeout(function(){
                    $('.fail-screen').css('display','none');
                    $('.popup-window').css('display','block');
                }, 1000);
            }

        }
    });
})


$('.ac').on('click tap touch',function() {
    $('.popup-window').css('display','none');
    $('.loading-screen').css('display','block');

    $(".register-submit").prop('disabled', true);
    var id = $(".id").val();
    var uname = $("#man-uname").val();
    var email = $("#man-email").val();
    var verification = $(".input-select").val();
    var account_type = $(".account-type").val();
    var sessions= $(".session-cb");
    var pr= $(".pr-cb");
    var ev= $(".ev-cb");
    var sessions2Delete='';
    var cc=0;
    for (cc=0;cc<sessions.length;cc++){
        if (sessions.eq(cc).is(":checked")){
            sessions2Delete+=sessions.eq(cc).attr("key")+'/***/';
        }
    }

    var pr2Delete='';
    if (pr.eq(0).is(":checked")){
        pr2Delete+=pr.eq(0).attr("key");
    }

    var ev2Delete='';
    if (ev.eq(0).is(":checked")){
        ev2Delete+=ev.eq(0).attr("key");
    }
    
    $.ajax({
        type:'POST',
        url:'/changeuserdata',
        data:'id='+id+'&username='+uname+'&email='+email+'&verification='+verification+'&account_type='+account_type+'&sessions2delete='+sessions2Delete+'&pr2delete='+pr2Delete+'&ev2delete='+ev2Delete,
        success:function (res) {
            if (res !="OK"){
                res = res.substring(2, res.length-2);
                var errors = res.split("', '");
                var e=0;
                var erroeFaildes=["username-error","email-error","account_type-error"]
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

                $('.loading-screen').css('display','none');
                $('.fail-screen').css('display','block');
                setTimeout(function(){
                    $('.fail-screen').css('display','none');
                    $('.popup-window').css('display','block');
                }, 1000);

            }
            else{
                $('.loading-screen').css('display','none');
                $('.success-screen').css('display','block');
                search();
                setTimeout(function(){
                    $('.success-screen').css('display','none');
                }, 1000);
            }
        }
    });
    return false; 
})