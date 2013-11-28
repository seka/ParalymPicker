exports.AppClass = class AppClass
  _keepExtention = true
  _engine = "ejs"
  _port = 3000
  _dir = "#{__dirname}/../../"

  constructor : () ->
    @port = _port
    @tmpDir = "#{_dir}tmp"
    @view   = "#{_dir}views"
    @public = "#{_dir}public"
    @routes = "#{_dir}routse"
    @favicon = "#{@public}/images/favicon.ico"

  getPort  : () ->
    return @port

  getView : () ->
    return @view

  getPublic : () ->
    return @public

  getRoutes : () ->
    return @routes

  getEngine : () ->
    return _engine

  getFavicon : () ->
    return @favicon

  upload : () ->
    return {
      uploadDir        : @tmpDir
      isKeepExtensions : _keepExtention
    }

  compress : () ->
    # option: 1~9で設定：1が最小,9が最大
    return {
      level: 9
      memLevel: 9
    }


