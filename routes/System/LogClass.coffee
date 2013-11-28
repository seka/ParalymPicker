exports.LogClass = class LogClass
  _dir = "#{__dirname}/../../logs"
  _size = 1024 * 1024
  _date = '-yyyy-MM-dd'

  constructer : () ->

  getName : () ->
    return "#{_dir}/log"

  getSize : () ->
    return _size

  getStdout : () ->
    return false

  getPattern : () ->
    return _date

  settings : () ->
    return {
      appenders : [
        {'type': 'console'}
        {
          'type'       : 'file'
          'filename'   : @getName()
          'maxLogSize' : @getSize()
          'pattern'    : @getPattern()
          'category'   : 'console'
        }
      ]
      replaceConsole : @getStdout()
    }

  connect : () ->
    return {
      nolog  :  [ '\\.css', '\\.js', '\\.gif', '\\.jpg', '\\.png' ]
      format : JSON.stringify {
        'method'     : ':method'
        'request'    : ':url'
        'status'     : ':status'
      }
    }

