Shoplift.RESTAdapter = DS.RESTAdapter.extend
  createRecord: (store, type, record) ->
    root = @rootForType(type)
    data = {}
    data[root] = record.toJSON()

    @ajax @buildURL(root), "POST",
      data: data,
      context: @,
      success: (json) ->
        @didCreateRecord(store, type, record, json)
      error: (json) ->
        store.recordWasInvalid(record, json.errors)


  # Override the ajax method to handle errors
  # TODO: would be love to just redefine the ajax method,
  # but unfortunately we need access to the record saved
  # for error handling.
  ___ajax: (url, type, hash) ->
    debugger
    hash.error = ->
    @_super(url, type, hash)
