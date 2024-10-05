self.addEventListener("install", (event) => {
    event.waitUntil(
      caches.open("greenmate-v1").then((cache) => {
        return cache.addAll([
          "/",
          "/site.webmanifest",
          "/android-chrome-192x192.png",
          "/android-chrome-512x512.png",
          "/favicon-16x16.png",
          "/favicon-32x32.png",
          "/favicon.ico",
          ]);
        })
      );
    });

  self.addEventListener("fetch", (event) => {
    event.respondWith(
      caches.match(event.request).then((response) => {
          return response || fetch(event.request);
        })
      );
    });