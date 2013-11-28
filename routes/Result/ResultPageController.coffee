exports.ResultPageClass = class ResultPageClass
  _pageName = 'result'

  constructor : (@option) ->
    @app = @option.app
    @node_modules = @option.node_modules
    @database = @option.database
    @serviceRoot = '../../service/Result/ResultPageService'

  getResultPage : () ->
    @app.get '/result', (req, res, next) =>
      ResultPageService = require(_serviceRoot).ResultPageService
      resultPageService = new ResultPageService(@app, @node_modules, @database, req, res, next)
      resultPageService.exec()

