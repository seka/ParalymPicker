exports.GetQuestionService = class GetQuestionService
  constructor : (@app, @node_modules, @database, @req, @res, @next) ->
    @async = @node_modules.async
    @categoryTable = @database.categoryTable

    # response ------------
    @jsons = []

  exec : () ->
    @async.series [
      @getCategory
      , @sendJson
    ] , (err, result) =>
      if (err)
        throw err
        @res.redirect '/'
      console.log "all done. #{result}"

  getCategory : (callBack) =>
    @categoryTable.findAll().success (columns) ->
      @jsons = []
      for column, i in columns
        @jsons[i] = {
          id : column.categoryID
          name : column.categoryName
        }
    .error (err) ->
      console.log "question json error >> #{err}"

  sendJson : (callBack) =>
    @res.send jsons
    callBack(null, 5)
