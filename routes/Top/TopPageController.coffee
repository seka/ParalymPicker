exports.TopPageClass = class TopPageClass
  _pageName = 'top'

  constructor : (@option) ->
    @app = @option.app
    @node_modules = @option.node_modules
    @database = @option.database

  getTopPage : () ->
    @app.get '/', (req, res, next) =>
      res.render(_pageName)

