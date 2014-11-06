# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
app = angular.module("RailsTodo", ["ngCachedResource", "ui.bootstrap"])

app.factory "Entry", ["$cachedResource", ($cachedResource) ->
  $cachedResource("entries", "/entries/:id", {id: "@id"})
]

@TodoCtrl = ["$scope", "Entry", (scope, Entry) ->
  scope.entries = Entry.query()

  scope.addEntry = ->
    entry = Entry.save(scope.newEntry)
    scope.entries.push(entry)
    scope.newEntry = {}

  scope.updateEntry = (entry) ->
  	Entry.update(entry)
  	entry.isopen = false

  scope.deleteEntry = (index, entry, event) ->
  	scope.entries.splice(index, 1)
  	Entry.delete(entry)

  scope.$watch('isopen', (newvalue, oldvalue, scope) ->
  	scope.isopen = newvalue
  	console.log ("Called on >>isopen<<; new is " + newvalue)
  )

]

angular.module("template/accordion/accordion-group.html", []).run(["$templateCache", ($templateCache) ->
  $templateCache.put("template/accordion/accordion-group.html",
  "<div class=\"panel panel-default\">\n" +
  "  <div class=\"panel-heading\" >\n" +
  "    <h4 class=\"panel-title\"><a data-toggle=\"collapse\" ng-click=\"isOpen = !isOpen\" accordion-transclude=\"heading\">{{heading}}</a></h4>\n" +
  "  </div>\n" +
  "  <div class=\"panel-collapse\" ng-hide=\"!isOpen\">\n" +
  "    <div class=\"panel-body\" ng-transclude></div>  </div>\n" +
  "</div>")
])

angular.module("template/accordion/accordion.html", []).run(["$templateCache", ($templateCache) -> 
  $templateCache.put("template/accordion/accordion.html",
  "<div class=\"panel-group\" ng-transclude></div>");
])