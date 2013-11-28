module.exports = (option) ->
  @app = option.app
  @database = option.database
  @node_modules = option.node_modules

  TopController = require './Top/TopPageController'
  topPageController = new TopController.TopPageClass(option)
  topPageController.getTopPage()

  QuestionController = require './Question/QuestionPageController'
  questionPageController = new QuestionController.QuestionPageClass(option)
  questionPageController.getQuestionPage()
  questionPageController.getQuestionJson()
  questionPageController.submitQuestion()

  SportsListController = require './SportsList/SportsListController'
  sportslistPageController = new SportsListController.SportsListPageClass(option)

  sportslistPageController.getSportsListPage()

  QuestionController = require './Question/QuestionPageController'
  questionPageController = new QuestionController.QuestionPageClass(option)
  questionPageController.getQuestionPage()
  questionPageController.getQuestionJson()

  ResultController = require './Result/ResultPageController'
  resultPageController = new ResultController.ResultPageClass(option)
  resultPageController.getResultPage()

  console.log "controller is setup"
