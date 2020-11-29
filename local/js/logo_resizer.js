var len = window.innerHeight;
var wid = window.innerWidth;
var logosize=Math.min(len,wid);
var mainlogo=document.getElementsByClassName('main-logo')[0];
mainlogo.setAttribute('style','height:'+(logosize-(logosize*0.5))+'px;width:'+(logosize-(logosize*0.5))+'px;');


setInterval(function(){
    var len = window.innerHeight;
    var wid = window.innerWidth;
    var logosize=Math.min(len,wid);
    var mainlogo=document.getElementsByClassName('main-logo')[0];
    mainlogo.setAttribute('style','height:'+(logosize-(logosize*0.5))+'px;width:'+(logosize-(logosize*0.5))+'px;');
}, 100);




