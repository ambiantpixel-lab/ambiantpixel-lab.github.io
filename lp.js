(function(){"use strict";
var f=document.querySelector('.screen iframe');
if(f){var s=f.parentNode,tag=s.querySelector('.tag'),vis=false;
function set(){var p=!vis||document.hidden;try{f.contentWindow.__pause=p}catch(e){}
try{f.contentWindow.postMessage({ap:'pause',v:p},location.origin)}catch(e){}
s.classList.toggle('paused',p);if(tag)tag.textContent=p?'PAUSED':'LIVE'}
if('IntersectionObserver' in window){new IntersectionObserver(function(es){vis=es[0].isIntersecting;set()},{threshold:0.1}).observe(s)}else{vis=true}
document.addEventListener('visibilitychange',set);f.addEventListener('load',set)}
try{if(matchMedia('(prefers-reduced-motion: reduce)').matches){document.querySelectorAll('video[autoplay]').forEach(function(v){v.removeAttribute('autoplay');v.pause()})}}catch(e){}
})();
