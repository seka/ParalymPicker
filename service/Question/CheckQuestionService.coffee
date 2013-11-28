exports.CheckQuestionService = class CheckQuestionService
  constructor : (@app, @node_modules, @database, @req, @res, @next) ->
    @results = @req.body.results
    @categoryTable = @database.categoryTable
    @eventTable = @database.eventTable
    @checkTable = @database.checkTable
    @async = @node_modules.async

    # response ------------
    @eventDatas = ""
    @checkLists = []
    @recommend = []
    @html = ""

  exec : () ->
    @async.series [
      @searchEvent
      , @getCheckList
      , @checkQuestions
      , @buildHtml
      , @sendHtml
    ] , (err, result) ->
      if (err)
        throw err
        res.redirect '/'
      console.log "all done. #{result}"

  searchEvent : (callBack) =>
    @eventTable.findAll().success (columns) =>
      @eventDatas = columns
      for i in [0...@eventDatas.length]
        @checkLists[i] = new Array()

      callBack(null, 1)
    .error (err) ->
      console.log "eventTable searchEventMethod err > #{err}"

  getCheckList : (callBack) =>
    @checkTable.findAll().success (columns) =>
      for column in columns
        if (column.flag)
          @checkLists[column.eventID - 1].push({
            categoryID: "#{column.categoryID}"
            flag: "true"
          })
        else
          @checkLists[column.eventID - 1].push({
            categoryID: "#{column.categoryID}"
            flag: "false"
          })
      callBack(null, 2)
    .error (err) ->
      console.log "checkTable getCheckListMethod err > #{err}"

  checkQuestions : (callBack) =>
    for i in [0...@eventDatas.length]
      flag = true

      if (@results.length isnt @checkLists[i].length)
        continue

      for j in [0...@results.length]
        if ((@results[j].categoryID isnt @checkLists[i][j].categoryID) or (@results[j].flag isnt @checkLists[i][j].flag))
          flag = false
          break

      if (flag is true)
        @recommend.push(i + 1)
    callBack(null, 3)

  buildHtml : (callBack) =>
    @html = ""
    for event in @eventDatas
      for i in [0...@recommend.length]
        if (event.eventID is @recommend[i])
          @html += """
            <div class="qu-content row">
              <a href='/result?eventID=#{event.eventID}'>
                <div class="event-icon_#{i} col-lg-4">
                  <img src="/images/#{event.eventID}_icon.png" alt="#{event.name_img}"/>
                  <p>#{event.name}</p>
                </div>
              </a>
            </div>
          """
    callBack(null, 4)

  sendHtml : (callBack) =>
    @res.send(@html)
    callBack(null, 5)
