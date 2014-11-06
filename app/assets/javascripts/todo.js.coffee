# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
app = angular.module("RailsTodo", ["ngCachedResource", "ui.bootstrap"])

app.factory "Entry", ["$cachedResource", ($cachedResource) ->
  $cachedResource("entries", "/entries/:id", {id: "@id"}, {update: {method: "PUT"}})
]

@TodoCtrl = ["$scope", "Entry", (scope, Entry) ->
  scope.entries = Entry.query()

  scope.addEntry = ->
    entry = Entry.save(scope.newEntry)
    scope.entries.push(entry)
    entry.$promise.then( ->
      console.log("Saving an entry")
      $cachedResource.clearUndefined()
      scope.newEntry = {}
    )

  scope.updateEntry = (entry) ->
  	Entry.update(entry)
  	entry.isopen = false

  scope.deleteEntry = (index, entry, event) ->
    scope.entries.splice(index, 1)
    d = Entry.delete(entry)
    d.$promise.then( ->
      $cachedResource.clearUndefined()
      console.log("Deleting an entry.")
    )

  scope.$watch('isopen', (newvalue, oldvalue, scope) ->
  	scope.isopen = newvalue
  )

]

