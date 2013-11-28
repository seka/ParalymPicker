exports.ResultPageService = class ResultPageService
  constructor : (@app, @node_modules, @database, @req, @res, @next) ->
    @async = @node_modules.async
    @eventTable = @database.eventTable
    @movieTable = @database.movieTable
    @eventID = @req.query.eventID

    # responce object ----------
    @pagename = "result"
    @eventName = ""
    @introduction = ""
    @pointText = ""
    @iconImage = ""
    @pointImage = ""
    @introImage = ""
    @movies = ""

  exec : () ->
    @async.series [
      @getDiagnosis
      , @getMovies
      , @getNext
    ] , (err, result) ->
      if (err)
        console.log err
        throw err
        res.redirect '/'
      console.log "all done. #{result}"

  getDiagnosis : (callBack) =>
    @eventTable.find(
      where : {
        eventID : @eventID
      }
    ).success (column) =>
      @eventName = column.name
      @introduction = column.introduction
      @pointText = column.point
      @iconImage = "<img src='/images/#{@eventID}_icon_large.png' alt='event_image' />"
      @pointImage = "<img src='/images/#{@eventID}_point.jpg' alt='event_point' />"
      @introImage = "<img src='/images/#{@eventID}_intro.jpg' alt='event_intro' />"
      callBack(null, 1)
    .error (err) ->
      console.log "eventTable getDiagonosisMethod err >> #{err}"

  getMovies : (callBack) =>
    @movieTable.findAll(
      where : {
        eventID : @eventID
      }
    ).success (columns) =>
      for column in columns
        @movies += """
          <div class='each-movie#{column.movieID} col-lg-4'>
            #{column.url}
          </div>
        """
      callBack(null, 2)

  getNext : (callBack) =>
    @res.render @pagename, {
      introduction : @introduction
      pointText    : @pointText
      sportsImage : @image
      pointImage  : @pointimage
      introImage  : @introimage
      movies      : @movies
    }
    callBack(null, 3)
