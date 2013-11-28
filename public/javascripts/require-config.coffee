###
# Todo.
# 余裕があれば jsのミニファイまでやる
###
###
do (require) ->
  require.config({
    baseURL以下のjsは自動で読み込み
    baseUrl : "/javascripts/"
    baseURL直下以外から読み込むライブラリを定義
    paths : {
      'jQuery'            : "../lib/jquery-1.9.1.min"
      'bootstrap'         : "../lib/bootstrap.min"
      'footerFixed'       : "../lib/footerFixed"
      'sonic'             : "../lib/sonic"
      'LoadingIconConfig' : "../Common/LoadingIconConfig"
    }
    AMD非対応プラグインに対する依存設定
    shim: {
      'jQuery' : {
        exports : '$'
      }
      'bootstrap' : {
        deps : ['jQuery']
      }
    }
  })

  <script>タグと同じ
  require([
    'jQuery'
    , 'bootstrap'
    , 'footerFixed'
    , 'sonic'
    , 'LoadingIconConfig'
  ], (app) ->
    console.log "require dane."
  )
###
