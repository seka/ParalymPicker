exports.SportsListPageClass = class SportsListPageClass
  _pageName = 'sportslist'

  constructor : (@option) ->
    @app = @option.app
    @node_modules = @option.node_modules
    @database = @option.database

  getSportsListPage : () ->
    @app.get '/sportslist', (req, res, next) =>
      res.render(_pageName)

