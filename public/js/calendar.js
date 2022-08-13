"use strict";document.addEventListener("DOMContentLoaded",function(){Filter.init(),Filter.onScroll(),Filter.getScrollDistance(),document.addEventListener("keyup",Filter.onEscPress),document.body.addEventListener("click",Filter.onClickBody)});var Filter={elm:null,elmEventContent:null,elmEventList:null,elmLoading:null,checkboxes:null,elmContentLoading:null,elmFilterCurrent:null,url:"",urlBackup:"",firstUrl:"",isOpen:!1,isResetComplete:!1,showLoading:!0,init:function(){Filter.elm=document.querySelector(".filter"),Filter.elm&&(Filter.elmEventList=document.getElementById("event-list"),Filter.elmEventContent=document.getElementById("program-section"),Filter.checkboxes=Filter.elm.querySelectorAll(".filter__option-checkbox"),Filter.elmContentLoading=Filter.elmEventContent.querySelector(".program-section__loading"),Filter.firstUrl=window.location.pathname,Filter.getLoading(),Filter.setUrl(document.location.pathname),Filter.getFilterCurrent(),Filter.responsiveArias(),window.addEventListener("scroll",Filter.onScroll),window.addEventListener("resize",Filter.responsiveArias),addEventListeners(Filter.elm.querySelectorAll("[data-button-action]"),"click",Filter.onClickAction),addEventListeners(Filter.elm.querySelectorAll(".filter__checkbox"),"change",Filter.onChangeGlobal),addEventListeners(Filter.checkboxes,"change",Filter.onClickOptions),addEventListeners(Filter.elm.querySelectorAll(".filter__link"),"click",Filter.onFiltered),addEventListeners(Filter.elm.querySelectorAll(".calendar__tbody"),"click",Filter.onDateFiltered),addEventListeners(Filter.elm.querySelectorAll(".calendar__today, .filter__button-clear"),"click",Filter.onSimpleFiltered),addEventListeners(Filter.elmEventContent.querySelectorAll("[data-current-link]"),"click",Filter.onSimpleFiltered))},onScroll:function(){if(Filter.elm){var e=Filter.elm.getBoundingClientRect().top,t=e<=0?"add":"remove",r=e<=0?!Filter.elm.classList.contains("filter--fixed"):Filter.elm.classList.contains("filter--fixed");r&&Filter.elm.classList[t]("filter--fixed"),r&&Header.dom.classList[t]("header--hide"),"remove"===t&&Filter.elm.classList.remove("filter--header-on"),Filter.setFilterCurrentFixed(),Filter.onLoadingAppear()}},onCloseFilters:function(){[].forEach.call(Filter.checkboxes,function(e){e.checked=!1,setAttributeAria(e.nextElementSibling,"expanded",!1),setAttributeAria(e.nextElementSibling.nextElementSibling,"hidden",!0)});var e=document.querySelector(".filter__wrapper");e.classList.remove("filter__wrapper--open"),Filter.isOpen=!1,setAttributeAria(document.querySelector(".filter__navigation-button--filter"),"expanded",!1),setAttributeAria(e,"hidden",!0)},onClickAction:function(e){e.preventDefault();var t=e.currentTarget.dataset.buttonAction,r=Filter.elm.querySelector("."+t),n=e.currentTarget.dataset.action,l=e.currentTarget.dataset.class;if("add"!==n&&"remove"!==n&&"toggle"!==n||r.classList[n](l),"calendar"===t){Calendar.elmButton.classList.toggle("filter__navigation-button--active"),setAttributeAria(Calendar.elmButton,"expanded",Calendar.elmButton.classList.contains("filter__navigation-button--active"))}"Calendar"in window&&Calendar.elmButton.classList.contains("filter__navigation-button--active")&&(Filter.onCloseFilters(),Filter.isOpen=!0,window.matchMedia("(min-width: 1366px)").matches&&Filter.onScrollToFilter()),e.currentTarget.classList.contains("filter__navigation-button")&&(Filter.isOpen=!0),(e.currentTarget.classList.contains("filter__button-back")||e.currentTarget.classList.contains("filter__button-close"))&&setAttributeAria(document.querySelector(".filter__navigation-button--filter"),"expanded",r.classList.contains(l)),!e.currentTarget.classList.contains("calendar__close")&&setAttributeAria(e.currentTarget,"expanded",r.classList.contains(l)),setAttributeAria(r,"hidden",!r.classList.contains(l))},onClickOptions:function(e){var t=e.target.checked;e.preventDefault(),[].forEach.call(Filter.checkboxes,function(e){e.checked=!1,setAttributeAria(e.nextElementSibling,"expanded",!1),setAttributeAria(e.nextElementSibling.nextElementSibling,"hidden",!0)}),e.target.checked=t,Filter.isOpen=t,t&&"Calendar"in window&&Calendar.onCloseAll(),Filter.isOpen&&window.matchMedia("(min-width: 1366px)").matches&&Filter.onScrollToFilter(),setAttributeAria(e.currentTarget.nextElementSibling,"expanded",t),setAttributeAria(e.currentTarget.nextElementSibling.nextElementSibling,"hidden",!t)},onChangeGlobal:function(e){var t=e.target.checked,r=document.getElementsByClassName(e.target.className);[].forEach.call(r,function(r){e.target.id===r.id&&(r.checked=t)}),Filter.onCloseFilters();var n=e.target.dataset.link;Filter.setUrl(n),Filter.onRequest("",!0)},onScrollToFilter:function(){Filter.elm.classList.contains("filter--fixed")||gsap.to(window,{duration:.74,delay:.32,ease:"power1.inOut",scrollTo:{y:"#program-section"}})},onLoadingAppear:function(){Filter.elmLoading&&Filter.elmEventList&&Filter.elmLoading.getBoundingClientRect().top<window.innerHeight&&Filter.showLoading&&(Filter.showLoading=!1,Filter.setUrl(Filter.elmEventList.lastElementChild.dataset.url),Filter.onRequest("ajax/1"))},onFiltered:function(e){e.preventDefault();var t=e.target.getAttribute("href"),r=Filter.getUrl();Filter.onCloseFilters(),e.target.classList.contains("checked")?(e.target.classList.remove("checked"),r=r.replace(t,"")):(e.target.classList.add("checked"),"/"===t[0]?r=t:(r="/"===r.substr(-1)?r:r+"/",r+=t)),Filter.setUrl(r),Filter.onRequest("",!0)},onDateFiltered:function(e){if(e.preventDefault(),"A"===e.target.nodeName.toUpperCase()){Calendar.onCloseAll();var t=e.target.getAttribute("href");Filter.setUrl(t),Filter.onRequest("",!0)}},onSimpleFiltered:function(e){e.preventDefault();var t=0;if((e.target.classList.contains("calendar__today")||e.target.classList.contains("filter__button-clear"))&&Calendar.onCloseAll(),e.target.classList.contains("filter-current__link")){var r=e.target.classList.contains("filter-current__link--all")?".filter-current__item":e.target.parentElement;gsap.to(r,{width:0,opacity:0,duration:.32,stagger:.12,ease:"power1.inOut"}),t=400}e.target.classList.contains("filter__button-clear")&&Filter.onCloseFilters(),setTimeout(function(){var t=e.target.getAttribute("href");Filter.setUrl(t),Filter.onRequest("",!0)},t)},onRequest:function(e,t){Filter.urlBackup=window.location.pathname,window.history.pushState("",window.title,Filter.getUrl()),t&&Filter.startRequestReset();var r=new XMLHttpRequest;r.addEventListener("load",function(e){4==e.target.readyState&&200==e.target.status&&(t?Filter.setRequestReset(e.target.response):Filter.setRequestList(e.target.responseText))}),r.open("GET",Filter.getUrl()+e,!0),r.send()},onClickBody:function(e){Filter.isOpen&&!hasClassParent(e.target,"filter")&&(Filter.onCloseFilters(),"Calendar"in window&&Calendar.onCloseAll())},onEscPress:function(e){"Escape"===e.key&&Filter.isOpen&&(Filter.onCloseFilters(),"Calendar"in window&&Calendar.onCloseAll(),Filter.isOpen=!1)},getScrollDistance:function(){Filter.elm&&ScrollDistance(function(e){Filter.elm.getBoundingClientRect().top<=-1500?e<0?Filter.elm.classList.contains("filter--hide")?parseInt(Math.abs(e),10)>35&&Filter.setHide("remove"):parseInt(Math.abs(e),10)>200&&(Filter.setHeaderHide("remove"),Filter.setHeaderOn()):parseInt(Math.abs(e),10)>35&&(Header.dom.classList.contains("header--hide")?(Filter.setHide(),Filter.isOpen&&(Filter.onCloseFilters(),"Calendar"in window&&Calendar.onCloseAll(),Filter.isOpen=!1)):(Filter.setHeaderHide(),Filter.setHeaderOn("remove"))):(Filter.setHide("remove"),e<0?parseInt(Math.abs(e),10)>200&&(Filter.setHeaderHide("remove"),Filter.setHeaderOn()):(Filter.setHeaderHide(),Filter.setHeaderOn("remove")),Filter.elm.getBoundingClientRect().top>0&&(Filter.setHeaderHide("remove"),Filter.setHeaderOn("remove")))})},getLoading:function(){Filter.elmEventList&&(Filter.elmLoading=Filter.elmEventList.querySelector(".loading-event"))},getUrl:function(){return Filter.url},getFilterCurrent:function(){Filter.elmFilterCurrent=Filter.elmEventContent.querySelector(".filter-current"),Filter.elmFilterCurrent&&(Filter.elmFilterCurrent.style.height="".concat(Filter.elmFilterCurrent.offsetHeight,"px"))},setHide:function(){var e=arguments.length>0&&void 0!==arguments[0]?arguments[0]:"add";Filter.elm.classList[e]("filter--hide"),Filter.elmFilterCurrent&&Filter.elmFilterCurrent.classList[e]("filter-current--hide")},setHeaderOn:function(){var e=arguments.length>0&&void 0!==arguments[0]?arguments[0]:"add";Filter.elm.classList[e]("filter--header-on"),Filter.elmFilterCurrent&&Filter.elmFilterCurrent.classList[e]("filter-current--header-on")},setHeaderHide:function(){var e=arguments.length>0&&void 0!==arguments[0]?arguments[0]:"add";Header.dom.classList[e]("header--hide")},setRequestList:function(e){gsap.to(Filter.elmLoading,{opacity:0,duration:.27,onComplete:function(){e.replace(/\r?\n|\r/g,"")?(Filter.elmLoading.remove(),Filter.elmEventList.innerHTML+=e,Filter.getLoading(),Filter.showLoading=!0,Filter.setIntersectionLink(),LineEffect.setLines(),Merklist.onRequestAlertsSuccess(),Merklist.setBookmarkActive(),Merklist.setListListener(),Presale.init()):(console.log("🎺 backup url 🎭"),window.history.pushState("",window.title,Filter.urlBackup))}})},setUrl:function(e){Filter.url=e},startRequestReset:function(){Filter.setHeaderOn("remove"),gsap.timeline().to(window,{duration:.74,delay:.32,ease:"power1.inOut",scrollTo:{y:"#program-section"}}).to(".event-list:not(.merklist-list), .event-list--empty, .filter-current",{duration:.28,opacity:0,onComplete:function(){Filter.elmContentLoading.style.display="block",gsap.to(Filter.elmContentLoading,{duration:.26,opacity:1,onComplete:function(){Filter.isResetComplete=!0}})}})},setRequestReset:function(e){var t=document.createElement("div");t.innerHTML=e;TimerFunction(function(){gsap.to(Filter.elmContentLoading,{opacity:0,duration:.28,onComplete:function(){Filter.elmEventContent.innerHTML=t.querySelector("#program-section").innerHTML,Calendar.init(),Filter.init(),LineEffect.setLines(),Merklist.onRequestAlertsSuccess(),Merklist.setBookmarkActive(),Merklist.setListListener(),Filter.getFilterCurrent(),Presale.init(),gsap.fromTo(".event-item, .event-list--empty, .filter-current",{opacity:0,y:-20},{opacity:1,duration:.32,y:0,stagger:.1,onComplete:function(){Filter.elmFilterCurrent&&(Filter.elmFilterCurrent.style.transform="")}})}}),Filter.isResetComplete=!1},function(){return Filter.isResetComplete})},setIntersectionLink:function(){var e=Filter.elmEventList.querySelectorAll("[data-url]");if(e.length&&window.IntersectionObserver){var t=new IntersectionObserver(function(t){return t.forEach(function(t){if(t.isIntersecting)window.history.pushState("",window.title,t.target.dataset.url);else if(t.target.getBoundingClientRect().top>window.innerHeight){var r="";[].forEach.call(e,function(n,l){n.dataset.url===t.target.dataset.url&&(r=0===l?Filter.firstUrl:e[--l].dataset.url)}),window.history.pushState("",window.title,r)}})},{root:null,threshold:[.1],rootMargin:"0px"});[].forEach.call(e,function(e){return t.observe(e)})}},setFilterCurrentFixed:function(){if(Filter.elmFilterCurrent){var e=Filter.elmFilterCurrent.getBoundingClientRect().top,t=Filter.elm.offsetHeight,r=e<t?"add":"remove";Filter.elmFilterCurrent.classList.contains("filter-current--fixed");Filter.elmFilterCurrent.classList[r]("filter-current--fixed"),"remove"===r&&Filter.elmFilterCurrent.classList.remove("filter-current--header-on")}},resetListEvents:function(){var e=document.querySelectorAll(".event-item:not(.event-item-noajax)");[].forEach.call(e,function(e){return e.classList.add("event-item-noajax")})},responsiveArias:function(){var e=document.querySelector(".filter__navigation-button--filter"),t=document.querySelector(".filter__wrapper"),r=window.matchMedia("(min-width: 1366px)").matches;setAttributeAria(e,"expanded",r),setAttributeAria(t,"hidden",!r)}},ScrollDistance=function(e,t){var r,n,l;e&&"function"==typeof e&&window.addEventListener("scroll",function(i){n||(n=window.pageYOffset),window.clearTimeout(r),r=setTimeout(function(){l=window.pageYOffset,e(l-n,n,l),n=null,l=null,null},t||66)},!1)};document.addEventListener("DOMContentLoaded",function(){Calendar.init()});var Calendar={elm:null,elmNext:null,elmPrev:null,elmButton:null,year:null,monthIndex:null,startDate:null,selectedDay:null,firstEventDate:null,lastEventDate:null,urlPattern:null,months:[],direction:"",init:function(){Calendar.elm=document.querySelector(".calendar"),Calendar.elmNext=Calendar.elm.querySelector(".calendar__next"),Calendar.elmPrev=Calendar.elm.querySelector(".calendar__prev"),Calendar.elmButton=document.querySelector(".filter__navigation-button--calendar"),Calendar.elmNext.addEventListener("click",Calendar.onNext),Calendar.elmPrev.addEventListener("click",Calendar.onPrev),Calendar.setConfigs(),Calendar.setLinkToday()},setConfigs:function(){var e=Calendar.elm.dataset,t=e.month-1,r={year:Number(e.year),monthIndex:t,startDate:new Date(e.year,t,1),selectedDay:new Date(e.year,t,e.day),firstEventDate:new Date(new Date(e.first_event_date).setHours("00","00","00")),lastEventDate:new Date(e.last_event_date),urlPattern:e.urlpattern};Object.assign(Calendar,r)},setLinkToday:function(){var e=document.querySelector(".calendar__today"),t=e.getAttribute("href"),r=new Date,n=r.getDate(),l=r.getMonth(),i=r.getFullYear(),a=Calendar.withZero(n)+"-"+Calendar.withZero(l+1)+"-"+i;t=t.replace("11-22-3333",a),e.setAttribute("href",t)},setDate:function(e,t){var r={monthIndex:e,year:t};Object.assign(Calendar,r),Calendar.render()},onCloseAll:function(){Calendar.elmButton.classList.remove("filter__navigation-button--active"),Calendar.elm.classList.remove("calendar--open"),setAttributeAria(Calendar.elmButton,"expanded",!1),setAttributeAria(Calendar.elm,"hidden",!0)},onNext:function(e){e.preventDefault(),Calendar.direction="right",Calendar.setDate(11==Calendar.monthIndex?0:Calendar.monthIndex+1,11==Calendar.monthIndex?Calendar.year+1:Calendar.year)},onPrev:function(e){e.preventDefault(),Calendar.direction="left",Calendar.setDate(0==Calendar.monthIndex?11:Calendar.monthIndex-1,0==Calendar.monthIndex?Calendar.year-1:Calendar.year)},withZero:function(e){return e<10?"0"+e:e},render:function(){var e=Calendar.monthIndex,t=Calendar.year,r=(Calendar.startDate,Calendar.selectedDay),n=new Date(t,e,1),l=new Date(11==e?t+1:t,11==e?0:e+1,1),i=new Date,a=Calendar.urlPattern;l=l.getTime()+60*(n.getTimezoneOffset()-l.getTimezoneOffset())*1e3,i.setHours(0),i.setMinutes(0),i.setSeconds(0),i.setMilliseconds(0);var o=n.getDay();0==o&&(o=7);var s=(l-n.getTime())/1e3/60/60/24;s=Math.floor(s);var d=getRange(s).map(function(n){var l=new Date(t,e,n+1),o=Calendar.withZero(n+1)+"-"+Calendar.withZero(e+1)+"-"+t,s="";return l-r==0&&(s="selected-day"),l-i==0&&(s+=" today"),l<i&&(s+=" past"),{day:n+1,href:a.replace("11-22-3333",o),class:s}}).reduce(function(e,t){var r=Math.floor((t.day+o-2)/7);return e.hasOwnProperty(r)||(e[r]=[]),e[r].push(t),e},{});d[0]=getRange(7-d[0].length).concat(d[0]),d[String(Object.keys(d).length-1)]=d[String(Object.keys(d).length-1)].concat(getRange(7-d[String(Object.keys(d).length-1)].length));var c={weeks:d,next_available:Calendar.lastEventDate>l,prev_available:Calendar.firstEventDate<=n};generateTemplate(c)}},getRange=function(e,t,r){var n=[],l=0;r=void 0===r?1:r,1===arguments.length?(l=e,t=e=0):(e=void 0===e?1:e,l=(t=void 0===t?1:t)-e);for(var i=0;i<l;)n.push(e+i*r),i+=1;return n},generateTemplate=function(e){var t=Calendar.elm.querySelector(".calendar__current-month"),r=Calendar.elm.querySelector(".calendar__current-year"),n=Calendar.elm.querySelector(".calendar__tbody");Calendar.elmNext.classList[e.next_available?"remove":"add"]("calendar__arrow-off"),Calendar.elmPrev.classList[e.prev_available?"remove":"add"]("calendar__arrow-off");var l=e.weeks,i="",a=e.prev_available?".calendar__current, .calendar__tbody":".calendar__current, .calendar__unavailable";for(var o in l){i+="<tr>";for(var s=0;s<l[o].length;s++)i+="<td>",l[o][s].day&&(i+='<a href="'+l[o][s].href+'" class="'+l[o][s].class+'">'+l[o][s].day+"</a>"),i+="</td>";i+="</tr>"}var d="left"===Calendar.direction?20:-20;gsap.timeline({}).to(".calendar__current, .calendar__tbody",{opacity:0,duration:.27,stagger:.1,x:d,onComplete:function(){n.innerHTML=i,t.innerText=Calendar.months[Calendar.monthIndex],r.innerText=Calendar.year,Calendar.elm.classList[e.prev_available?"remove":"add"]("calendar--off")}}).set(a,{x:-1*d,opacity:0}).to(a,{opacity:1,x:0,duration:.27,stagger:.1})};