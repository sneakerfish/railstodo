railstodo
=========

Todo list manager using rails and angularjs.  This uses angular-cached-resource module to cache
the results to localstorage so that the application can continue to operate while disconnected
from the internet.  Additional items added while offline will be added after connecting again.

There's a small bug right now, in that it adds extra entries created during down time TWICE.

