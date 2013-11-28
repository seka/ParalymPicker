exports.QuestionPageClass = class QuestionPageClass
  _pageName = 'question'
  _checkQuestionRoot = '../../service/Question/CheckQuestionService'
  _getQuestionRoot = '../../service../Question/GetQuestionService'

  constructor : (@option) ->
    @app = @option.app
    @node_modules = @option.node_modules
    @database = @option.database

  getQuestionPage : () ->
    @app.get '/question', (req, res) ->
      res.render(_pageName)

  getQuestionJson : () ->
    @app.post '/question/json', (req, res) =>
      GetQuestionService = require(_getQuestionRoot).GetQuestionService
      getQuestionService = new GetQuestionService(@app, @node_modules, @database, req, res)
      getQuestionService.exec()

  submitQuestion : () ->
    @app.post '/submit', (req, res) =>
      CheckQuestionService = require(_checkQuestionRoot).CheckQuestionService
      checkQuestionService = new CheckQuestionService(@app, @node_modules, @database, req, res)
      checkQuestionService.exec()


