'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "b3a597f4a5744239facffdca1ff6f1bc",
"index.html": "553c232012b269d81c367228699fb9c9",
"/": "553c232012b269d81c367228699fb9c9",
"main.dart.js": "6372ded1ab8c64b65d5c2d76d86c8c32",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"_redirects": "6a02faf7ea2a9584134ffe15779a0e44",
"favicon.png": "c7c3d5c97140a98e5cacbe6ca00356df",
"main-icon.png": "c1e436b1c29204d242c34a8417f01c11",
"assets/AssetManifest.json": "b4044d03871a0662668d90512cea164f",
"assets/NOTICES": "202b9276661bd39467d89b40a0bc980b",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/packages/dash_chat_2/assets/placeholder.png": "ce1fece6c831b69b75c6c25a60b5b0f3",
"assets/packages/dash_chat_2/assets/profile_placeholder.png": "77f5794e2eb49f7989b8f85e92cfa4e0",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/lib/assets/design.png": "fbe8e637c6c12bb1a8d09c3c282800d0",
"assets/lib/assets/8.png": "2d00f35e05318645cfbaea88cac85cf8",
"assets/lib/assets/9.png": "b51341af12d4a2c8a82feea459954f11",
"assets/lib/assets/master-web-hero-image.png": "b29defcfe49f6b0ae655e9cf3f110da9",
"assets/lib/assets/6.jpeg": "7eacd1048f4596820af7b4ab1bdd740e",
"assets/lib/assets/arrow.png": "a7e67bac297ececf183671c73b9ebee4",
"assets/lib/assets/11.png": "2d63c81d6984b78702a87e4619d10f45",
"assets/lib/assets/10.png": "0f3c47f1065465079d9d20e6fa5bdce9",
"assets/lib/assets/arrow2.png": "b1822fa0e310d2347ce7f9ea60d77bbd",
"assets/lib/assets/4.jpeg": "f6b0b4d55cb7063249f668faceb87141",
"assets/lib/assets/footer.png": "17b6fdac23051d8f719adb026cbd164e",
"assets/lib/assets/startup.png": "d413ad94e5b94537778bdf70f32eb397",
"assets/lib/assets/5.jpg": "ea2ac60fdd616320bf9bed04afc036d7",
"assets/lib/assets/7.png": "290c77ad3131767c83d1dfe5a7079fb0",
"assets/lib/assets/start.jpeg": "18b586713ca809b1112a7332923c3a07",
"assets/lib/assets/2.JPG": "9b6ef21612f08448864b90bddc060e9f",
"assets/lib/assets/3.png": "db37ec3050bfbc1f4e300f351e5e484c",
"assets/lib/assets/1.JPG": "9703ea2745916cce1cd97b48854f4d44",
"assets/lib/assets/robotics.png": "18c83925b9258f26218d975e7a22e639",
"assets/lib/assets/start.png": "ffb24a7a8623324f02c6e9bfa6bc5c7d",
"assets/lib/assets/social.png": "d3aa22c9cb903910552c9e72bc5c6241",
"assets/lib/assets/res2.png": "ec598c6b2e1f48d2f27d0ae68877dcf3",
"assets/AssetManifest.bin": "64ed7be934b6d7de4986d37ec69ed197",
"assets/fonts/MaterialIcons-Regular.otf": "ab0a746176e2294238fd2a6efd9a7fb6",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "1165572f59d51e963a5bf9bdda61e39b",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "19d8b35640d13140fe4e6f3b8d450f04",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
