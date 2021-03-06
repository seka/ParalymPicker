// Generated by CoffeeScript 1.6.2
var QuestionPageClass;

exports.QuestionPageClass = QuestionPageClass = (function() {
  var _checkQuestionRoot, _getQuestionRoot, _pageName;

  _pageName = 'question';

  _checkQuestionRoot = '../../service/Question/CheckQuestionService';

  _getQuestionRoot = '../../service../Question/GetQuestionService';

  function QuestionPageClass(option) {
    this.option = option;
    this.app = this.option.app;
    this.node_modules = this.option.node_modules;
    this.database = this.option.database;
  }

  QuestionPageClass.prototype.getQuestionPage = function() {
    return this.app.get('/question', function(req, res) {
      return res.render(_pageName);
    });
  };

  QuestionPageClass.prototype.getQuestionJson = function() {
    var _this = this;

    return this.app.post('/question/json', function(req, res) {
      var GetQuestionService, getQuestionService;

      GetQuestionService = require(_getQuestionRoot).GetQuestionService;
      getQuestionService = new GetQuestionService(_this.app, _this.node_modules, _this.database, req, res);
      return getQuestionService.exec();
    });
  };

  QuestionPageClass.prototype.submitQuestion = function() {
    var _this = this;

    return this.app.post('/submit', function(req, res) {
      var CheckQuestionService, checkQuestionService;

      CheckQuestionService = require(_checkQuestionRoot).CheckQuestionService;
      checkQuestionService = new CheckQuestionService(_this.app, _this.node_modules, _this.database, req, res);
      return checkQuestionService.exec();
    });
  };

  return QuestionPageClass;

})();

/*
//@ sourceMappingURL=QuestionPageController.map
*/
