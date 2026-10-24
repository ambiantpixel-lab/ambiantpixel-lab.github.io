(function(){"use strict";
var f=document.querySelector('.screen iframe');
if(f){var s=f.parentNode,tag=s.querySelector('.tag'),vis=false;
function set(){var p=!vis||document.hidden;try{f.contentWindow.__pause=p}catch(e){}
try{f.contentWindow.postMessage({ap:'pause',v:p},location.origin)}catch(e){}
s.classList.toggle('paused',p);if(tag)tag.textContent=p?'PAUSED':'LIVE'}
if('IntersectionObserver' in window){new IntersectionObserver(function(es){vis=es[0].isIntersecting;set()},{threshold:0.1}).observe(s)}else{vis=true}
document.addEventListener('visibilitychange',set);f.addEventListener('load',set)}
/* soldes Halloween itch : 2026-10-25 17:00 UTC -> 2026-11-04 18:00 UTC ; rien ne s'affiche hors de cette fenetre */
var n=Date.now();if(n>=Date.parse('2026-10-25T17:00:00Z')&&n<Date.parse('2026-11-04T18:00:00Z')){var h=document.querySelector('header');if(h){var d=document.createElement('div');d.className='sale';d.id='sale';
var e=new Date(Date.parse('2026-11-04T18:00:00Z')).toLocaleString('en-US',{month:'long',day:'numeric',hour:'numeric',minute:'2-digit'});
d.innerHTML='<div class="wrap"><p><b>Halloween Sale: 30% off every wallpaper</b> on itch.io, all 8 paid packs together for $42 instead of $60. Ends '+e+'.</p><a class="cta sm" href="https://itch.io/s/209347/halloween-sale-30-off-every-ambiant-pixel-wallpaper">See the sale &#8599;</a></div>';h.insertAdjacentElement('afterend',d)}}
try{if(matchMedia('(prefers-reduced-motion: reduce)').matches){document.querySelectorAll('video[autoplay]').forEach(function(v){v.removeAttribute('autoplay');v.pause()})}}catch(e){}
})();
