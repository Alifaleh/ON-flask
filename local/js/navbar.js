$(".logout-btn").on('click tap touch',function() {


    $.ajax({
        type:'POST',
        url:'/logout',
        data:'logout=1',
        success:function (res) {
            location.reload(true);
        }})


})