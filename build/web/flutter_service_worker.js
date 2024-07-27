'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "b3a597f4a5744239facffdca1ff6f1bc",
"index.html": "654ecc0913a73ce497cad531dc6775fb",
"/": "654ecc0913a73ce497cad531dc6775fb",
"main.dart.js": "da7974647d2333ef5c5f2dd97247fe7e",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "c7c3d5c97140a98e5cacbe6ca00356df",
"main-icon.png": "c1e436b1c29204d242c34a8417f01c11",
"assets/AssetManifest.json": "1d5208a111049733f11afdb2bdf07074",
"assets/NOTICES": "8bdf7026e1eeb89db5405f258329f77f",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "6cdae97b4a19a0ee358c043e024903ab",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "ffd063c5ddbbe185f778e7e41fdceb31",
"assets/packages/dash_chat_2/assets/placeholder.png": "ce1fece6c831b69b75c6c25a60b5b0f3",
"assets/packages/dash_chat_2/assets/profile_placeholder.png": "77f5794e2eb49f7989b8f85e92cfa4e0",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/lib/assets/tinkercad.png": "ba357b67cd4650711798e14853205a74",
"assets/lib/assets/design.png": "fbe8e637c6c12bb1a8d09c3c282800d0",
"assets/lib/assets/appr.png": "2e31184ba720b1847f971d46ecb1461a",
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
"assets/lib/assets/3ds.jpg": "93b6cd035dd483611208b9488f17943b",
"assets/lib/assets/startup.png": "d413ad94e5b94537778bdf70f32eb397",
"assets/lib/assets/5.jpg": "ea2ac60fdd616320bf9bed04afc036d7",
"assets/lib/assets/7.png": "290c77ad3131767c83d1dfe5a7079fb0",
"assets/lib/assets/start.jpeg": "18b586713ca809b1112a7332923c3a07",
"assets/lib/assets/blender.jpg": "c825f46637916d5f71a2996b35522186",
"assets/lib/assets/2.JPG": "9b6ef21612f08448864b90bddc060e9f",
"assets/lib/assets/3.png": "db37ec3050bfbc1f4e300f351e5e484c",
"assets/lib/assets/1.JPG": "9703ea2745916cce1cd97b48854f4d44",
"assets/lib/assets/robotics.png": "18c83925b9258f26218d975e7a22e639",
"assets/lib/assets/start.png": "ffb24a7a8623324f02c6e9bfa6bc5c7d",
"assets/lib/assets/social.png": "d3aa22c9cb903910552c9e72bc5c6241",
"assets/lib/assets/res2.png": "ec598c6b2e1f48d2f27d0ae68877dcf3",
"assets/AssetManifest.bin": "43d721683a22afe02e02d9e537191e04",
"assets/fonts/MaterialIcons-Regular.otf": "127a878de07e53c2f8725339104c8ff0",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
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
