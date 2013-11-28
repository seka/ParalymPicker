module.exports = (options) ->
  config = options.config.database
  sequelize = options.node_modules.sequelize

  # databaseの定義を記述する
  # database名、ユーザ、パスワード、ホストネーム、ポート
  # ホストネームはサーバのip?
  dbname = config.dbname
  dbuser = config.dbuser
  dbpass = config.server_pass
  hostname = config.hostname
  portnum = config.port

  seq = new sequelize(dbname, dbuser, dbpass, {
    host: hostname
    port: portnum
  })

  # データベースオブジェクトの作成
  Database = {}
  columns = {}

  # defaultで付与されるタイムスタンプを付けない
  # テーブルネームを複数形にしない（定義した名前を使用する）
  seq_option = {
    timestamps     : false
    freezeTableName: true
  }

  # O/Rマッパーがサポートしていない範囲のSQLを発行する
  Database.seq = seq

  # Event_table オブジェクト
  columns.eventTable = {
    eventID      : {type: sequelize.INTEGER, primaryKey: true}
    name         : sequelize.STRING
    introduction : sequelize.TEXT
    point        : sequelize.TEXT
  }
  Database.eventTable = seq.define("event_table", columns.eventTable, seq_option)

  # Category_table オブジェクト
  columns.categoryTable = {
    categoryID   : {type: sequelize.INTEGER, primaryKey: true}
    categoryName : sequelize.STRING
  }
  Database.categoryTable = seq.define("category_table", columns.categoryTable, seq_option)

  # Check_table オブジェクト
  columns.checkTable = {
      eventID    : {type: sequelize.INTEGER, primaryKey: true}
      categoryID : {type: sequelize.INTEGER, primaryKey: true}
      flag       : sequelize.BOOLEAN
    }
  Database.checkTable = seq.define("check_table", columns.checkTable, seq_option)

  # Movie_table オブジェクト
  columns.movieTable = {
      eventID    : {type: sequelize.INTEGER, primaryKey: true}
      movieID    : {type: sequelize.INTEGER, primaryKey: true}
      url        : sequelize.TEXT
    }
  Database.movieTable = seq.define("movie_table", columns.movieTable, seq_option)



  console.log 'Database is setup.'

  return Database
