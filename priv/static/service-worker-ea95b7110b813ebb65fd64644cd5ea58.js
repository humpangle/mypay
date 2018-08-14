"use strict";var precacheConfig=[["/css/commons.css","e84d659854f1f1550c68f4301c7fba57"],["/css/commons.js","192ffb0cda65e2fcbbfd340ac8af682b"],["/css/components/new-meta-form.css","1ac24bd7ae65962ed117cd9f5c876f58"],["/css/components/new-meta-form.js","6ec52bf7ac6101fbb3ed66d3f65ac8b8"],["/css/routes/index.css","544e462192d76ffd68ce634a2ff1b4ab"],["/css/routes/index.js","9c1c7b3bb945ff7542028ccc258106a0"],["/css/routes/shift.css","9a695dca03aa22248157631378c885a0"],["/css/routes/shift.js","2ed8645327398f33ba5a83814d27af88"],["/fonts/brand-icons.eot","13db00b7a34fee4d819ab7f9838cc428"],["/fonts/brand-icons.ttf","c5ebe0b32dc1b5cc449a76c4204d13bb"],["/fonts/brand-icons.woff","a046592bac8f2fd96e994733faf3858c"],["/fonts/brand-icons.woff2","e8c322de9658cbeb8a774b6624167c2c"],["/fonts/icons.eot","8e3c7f5520f5ae906c6cf6d7f3ddcd19"],["/fonts/icons.ttf","b87b9ba532ace76ae9f6edfe9f72ded2"],["/fonts/icons.woff","faff92145777a3cbaf8e7367b4807987"],["/fonts/icons.woff2","0ab54153eeeca0ce03978cc463b257f7"],["/fonts/outline-icons.eot","701ae6abd4719e9c2ada3535a497b341"],["/fonts/outline-icons.ttf","ad97afd3337e8cda302d10ff5a4026b8"],["/fonts/outline-icons.woff","ef60a4f6c25ef7f39f2d25a748dbecfe"],["/fonts/outline-icons.woff2","cd6c777f1945164224dee082abaea03a"],["/img/9c74e172f87984c48ddf5c8108cabe67.png","9c74e172f87984c48ddf5c8108cabe67"],["/img/a62ade4dc867325497238bbbe6770712.svg","a62ade4dc867325497238bbbe6770712"],["/img/e463db5ab162e92fd3ffcbd8ccc8d9f9.svg","e463db5ab162e92fd3ffcbd8ccc8d9f9"],["/img/f2b5ce0181c898dc5a2fe93fb0c7564a.svg","f2b5ce0181c898dc5a2fe93fb0c7564a"],["/js/commons.js","98b054f9369765b62fcddad60d14264d"],["/js/routes/index.js","7ae06e880f78870157f8c472f52e1e44"],["/js/routes/shift.js","abc9e96ac78c819344533b6809fe288d"]],cacheName="sw-precache-v3-sw-precache-webpack-plugin-"+(self.registration?self.registration.scope:""),ignoreUrlParametersMatching=[/^utm_/],addDirectoryIndex=function(e,n){var t=new URL(e);return"/"===t.pathname.slice(-1)&&(t.pathname+=n),t.toString()},cleanResponse=function(e){return e.redirected?("body"in e?Promise.resolve(e.body):e.blob()).then(function(n){return new Response(n,{headers:e.headers,status:e.status,statusText:e.statusText})}):Promise.resolve(e)},createCacheKey=function(e,n,t,c){var a=new URL(e);return c&&a.pathname.match(c)||(a.search+=(a.search?"&":"")+encodeURIComponent(n)+"="+encodeURIComponent(t)),a.toString()},isPathWhitelisted=function(e,n){if(0===e.length)return!0;var t=new URL(n).pathname;return e.some(function(e){return t.match(e)})},stripIgnoredUrlParameters=function(e,n){var t=new URL(e);return t.hash="",t.search=t.search.slice(1).split("&").map(function(e){return e.split("=")}).filter(function(e){return n.every(function(n){return!n.test(e[0])})}).map(function(e){return e.join("=")}).join("&"),t.toString()},hashParamName="_sw-precache",urlsToCacheKeys=new Map(precacheConfig.map(function(e){var n=e[0],t=e[1],c=new URL(n,self.location),a=createCacheKey(c,hashParamName,t,/\.\w{8}\./);return[c.toString(),a]}));function setOfCachedUrls(e){return e.keys().then(function(e){return e.map(function(e){return e.url})}).then(function(e){return new Set(e)})}self.addEventListener("install",function(e){e.waitUntil(caches.open(cacheName).then(function(e){return setOfCachedUrls(e).then(function(n){return Promise.all(Array.from(urlsToCacheKeys.values()).map(function(t){if(!n.has(t)){var c=new Request(t,{credentials:"same-origin"});return fetch(c).then(function(n){if(!n.ok)throw new Error("Request for "+t+" returned a response with status "+n.status);return cleanResponse(n).then(function(n){return e.put(t,n)})})}}))})}).then(function(){return self.skipWaiting()}))}),self.addEventListener("activate",function(e){var n=new Set(urlsToCacheKeys.values());e.waitUntil(caches.open(cacheName).then(function(e){return e.keys().then(function(t){return Promise.all(t.map(function(t){if(!n.has(t.url))return e.delete(t)}))})}).then(function(){return self.clients.claim()}))}),self.addEventListener("fetch",function(e){if("GET"===e.request.method){var n,t=stripIgnoredUrlParameters(e.request.url,ignoreUrlParametersMatching);(n=urlsToCacheKeys.has(t))||(t=addDirectoryIndex(t,"index.html"),n=urlsToCacheKeys.has(t));!n&&"navigate"===e.request.mode&&isPathWhitelisted(["^(?!\\/__).*"],e.request.url)&&(t=new URL("/",self.location).toString(),n=urlsToCacheKeys.has(t)),n&&e.respondWith(caches.open(cacheName).then(function(e){return e.match(urlsToCacheKeys.get(t)).then(function(e){if(e)return e;throw Error("The cached response that was expected is missing.")})}).catch(function(n){return console.warn('Couldn\'t serve response for "%s" from cache: %O',e.request.url,n),fetch(e.request)}))}});