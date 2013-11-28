### ------- Module dependencies. ------------ ###
express = require 'express'
cluster = require 'cluster'
engine  = require 'ejs-locals'
http    = require 'http'
log4js  = require 'crafity-log4js'
sequelize = require 'sequelize'
async = require 'async'
app = express()

### ------- Class --------------------------- ###
appOption = require './config/test_option.json'
AppClass = require './routes/System/AppClass'
LogClass = require './routes/System/LogClass'

appConfig = new AppClass.AppClass()
logConfig = new LogClass.LogClass()

node_modules = {}
node_modules.express = express
node_modules.cluster = cluster
node_modules.engine = engine
node_modules.http = http
node_modules.log4js = log4js
node_modules.sequelize = sequelize
node_modules.async = async
node_modules.appClass = appConfig

### ------- middleware ------------------------ ###
app.configure ->
  app.set 'port', appConfig.getPort()
  app.set 'views', appConfig.getView()
  app.engine 'ejs', engine
  app.set 'view engine', appConfig.getEngine()
  app.use express.favicon(appConfig.getFavicon())

  # log -----------------------
  logger = log4js.getLogger('file')
  log4js.configure(logConfig.settings)
  app.use log4js.connectLogger(logger, logConfig.connect())

  app.use express.compress(appConfig.compress) # 応答データの圧縮
  app.use express.bodyParser(appConfig.upload()) # upload /  postのリクエスト処理
  app.use express.methodOverride()
  app.use express.static appConfig.getPublic()

  return console.log "app opption setup."

### ------- create httpServer.----------------- ###
# masterサーバの設定（clusterを使ってプロセスをフォークする場合
if (cluster.isMaster)
  server = http.createServer(app)

  # database setup
  database_root = "./database/database"
  database = require(database_root)(config : appOption, node_modules : node_modules)

  # server setup
  # serverを立ち上げたことにcontrollerを立ち上げる
  server.listen app.get('port'), ->
    console.log "Master Server listening on #{app.get('port')}"
    # controller setup
    controller = "#{__dirname}/routes/controller"
    require(controller)(app : app, database : database, node_modules : node_modules)

### ------- Error. ----------------------------------------- ###
# nodeがERRによって突然死しないようにする
process.on 'uncaughtException', (err) ->
  console.log "err >  #{err}"
  console.error "uncaughtException >  #{err.stack}"

