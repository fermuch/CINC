###
Bootstrap-Admin-Template by onokumus@gmail.com
Version : 2.0.0
Author : Osman Nuri Okumuş
Copyright 2013
###
dashboard = ->
  
  #----------- BEGIN SPARKLINE CODE -------------------------*/
  # required jquery.sparkline.min.js*/
  
  ###
  This code runs when everything has been loaded on the page
  ###
  
  # Inline sparklines take their values from the contents of the tag 
  
  # Sparklines can also take their values from the first argument
  #     passed to the sparkline() function 
  
  # The second argument gives options such as chart type 
  
  # Use 'html' instead of an array of values to pass options
  #     to a sparkline with data in the tag 
  
  #----------- END SPARKLINE CODE -------------------------*/
  
  #----------- BEGIN FULLCALENDAR CODE -------------------------*/
  # make the event "stick"
  
  #----------- END FULLCALENDAR CODE -------------------------
  
  #----------- BEGIN CHART CODE -------------------------
  showTooltip = (x, y, contents) ->
    $("<div id=\"tooltip\">" + contents + "</div>").css(
      position: "absolute"
      display: "none"
      top: y + 5
      left: x + 5
      border: "1px solid #fdd"
      padding: "2px"
      "background-color": "#000"
      color: "#fff"
    ).appendTo("body").fadeIn 200
  "use strict"
  $(".inlinesparkline").sparkline()
  myvalues = [10, 8, 5, 7, 4, 4, 1]
  $(".dynamicsparkline").sparkline myvalues
  $(".dynamicbar").sparkline myvalues,
    type: "bar"
    barColor: "green"

  $(".inlinebar").sparkline "html",
    type: "bar"
    barColor: "red"

  $(".sparkline.bar_week").sparkline [5, 6, 7, 2, 0, -4, -2, 4],
    type: "bar"
    height: "40"
    barWidth: 5
    barColor: "#4d6189"
    negBarColor: "#a20051"

  $(".sparkline.line_day").sparkline [5, 6, 7, 9, 9, 5, 4, 6, 6, 4, 6, 7],
    type: "line"
    height: "40"
    drawNormalOnTop: false

  $(".sparkline.pie_week").sparkline [1, 1, 2],
    type: "pie"
    width: "40"
    height: "40"

  $(".sparkline.stacked_month").sparkline ["0:2", "2:4", "4:2", "4:1"],
    type: "bar"
    height: "40"
    barWidth: 10
    barColor: "#4d6189"
    negBarColor: "#a20051"

  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()
  calendar = $("#calendar").fullCalendar(
    header:
      left: "prev,today,next,"
      center: "title"
      right: "month,agendaWeek,agendaDay"

    selectable: true
    selectHelper: true
    select: (start, end, allDay) ->
      title = prompt("Event Title:")
      if title
        calendar.fullCalendar "renderEvent",
          title: title
          start: start
          end: end
          allDay: allDay
        , true
      calendar.fullCalendar "unselect"

    editable: true
    events: [
      title: "All Day Event"
      start: new Date(y, m, 1)
      className: "label label-success"
    ,
      title: "Long Event"
      start: new Date(y, m, d - 5)
      end: new Date(y, m, d - 2)
      className: "label label-info"
    ,
      id: 999
      title: "Repeating Event"
      start: new Date(y, m, d - 3, 16, 0)
      allDay: false
      className: "label label-warning"
    ,
      id: 999
      title: "Repeating Event"
      start: new Date(y, m, d + 4, 16, 0)
      allDay: false
      className: "label label-inverse"
    ,
      title: "Meeting"
      start: new Date(y, m, d, 10, 30)
      allDay: false
      className: "label label-important"
    ,
      title: "Lunch"
      start: new Date(y, m, d, 12, 0)
      end: new Date(y, m, d, 14, 0)
      allDay: false
    ,
      title: "Birthday Party"
      start: new Date(y, m, d + 1, 19, 0)
      end: new Date(y, m, d + 1, 22, 30)
      allDay: false
    ,
      title: "Click for Google"
      start: new Date(y, m, 28)
      end: new Date(y, m, 29)
      url: "http://google.com/"
    ]
  )
  sin = []
  cos = []
  i = 0

  while i < 14
    sin.push [i, Math.sin(i)]
    cos.push [i, Math.cos(i)]
    i += 0.5
  plot = $.plot($("#trigo"), [
    data: sin
    label: "sin(x)"
    points:
      fillColor: "#4572A7"
      size: 5

    color: "#4572A7"
  ,
    data: cos
    label: "cos(x)"
    points:
      fillColor: "#333"
      size: 35

    color: "#AA4643"
  ],
    series:
      lines:
        show: true

      points:
        show: true

    grid:
      hoverable: true
      clickable: true

    yaxis:
      min: -1.2
      max: 1.2
  )
  previousPoint = null
  $("#trigo").bind "plothover", (event, pos, item) ->
    $("#x").text pos.x.toFixed(2)
    $("#y").text pos.y.toFixed(2)
    if item
      if previousPoint isnt item.dataIndex
        previousPoint = item.dataIndex
        $("#tooltip").remove()
        x = item.datapoint[0].toFixed(2)
        y = item.datapoint[1].toFixed(2)
        showTooltip item.pageX, item.pageY, item.series.label + " of " + x + " = " + y
    else
      $("#tooltip").remove()
      previousPoint = null

  
  #----------- END CHART CODE -------------------------
  
  #----------- BEGIN TABLESORTER CODE -------------------------
  
  # required jquery.tablesorter.min.js
  $(".sortableTable").tablesorter()

#----------- END TABLESORTER CODE -------------------------
metisChart = ->
  
  # a null signifies separate line segments
  lemniscatex = (i) ->
    Math.sqrt(2) * Math.cos(i) / (Math.pow(Math.sin(i), 2) + 1)
  lemniscatey = (i) ->
    Math.sqrt(2) * Math.cos(i) * Math.sin(i) / (Math.pow(Math.sin(i), 2) + 1)
  "use strict"
  d2 = [[0, 3], [1, 8], [2, 5], [3, 13], [4, 1]]
  d3 = [[0, 12], [2, 2], [3, 9], [4, 4]]
  $.plot $("#trigo"), [
    data: d2
    label: "MAN"
  ,
    data: d3
    label: "WOMAN"
  ],
    clickable: true
    hoverable: true
    series:
      lines:
        show: true
        fill: true
        fillColor:
          colors: [
            opacity: 0.5
          ,
            opacity: 0.15
          ]

      points:
        show: true

  $.plot $("#trigo2"), [
    data: d2
    label: "BAR"
  ],
    clickable: true
    hoverable: true
    series:
      bars:
        show: true
        barWidth: 0.6

      points:
        show: true

  parabola = []
  parabola2 = []
  i = -5

  while i <= 5
    parabola.push [i, Math.pow(i, 2) - 25]
    parabola2.push [i, -Math.pow(i, 2) + 25]
    i += 0.5
  circle = []
  c = -2

  while c <= 2.1
    circle.push [c, Math.sqrt(400 - c * c * 100)]
    circle.push [c, -Math.sqrt(400 - c * c * 100)]
    c += 0.1
  daire = [3]
  $.plot $("#eye"), [
    data: parabola2
    lines:
      show: true
      fill: true
  ,
    data: parabola
    lines:
      show: true
      fill: true
  ,
    data: circle
    lines:
      show: true
  ]
  heart = []
  i = -2
  while i <= 5
    heart.push [16 * Math.pow(Math.sin(i), 3), 13 * Math.cos(i) - 5 * Math.cos(2 * i) - 2 * Math.cos(3 * i) - Math.cos(4 * i)]
    i += 0.01
  $.plot $("#heart"), [
    data: heart
    label: "<i class=\"icon-heart icon-2x\"></i>"
    color: "#9A004D"
  ],
    series:
      lines:
        show: true
        fill: true

      points:
        show: false

    yaxis:
      show: true

    xaxis:
      show: true

  $("#heart .legendLabel").addClass "animated pulse"
  bernoulli = []
  k = 0

  while k <= 2 * Math.PI
    bernoulli.push [lemniscatex(k), lemniscatey(k)]
    k += 0.01
  $.plot $("#bernoilli"), [
    data: bernoulli
    label: "Lemniscate of Bernoulli"
    lines:
      show: true
      fill: true
  ]
formGeneral = ->
  "use strict"
  $(".with-tooltip").tooltip selector: ".input-tooltip"
  
  #----------- BEGIN autosize CODE -------------------------
  $("#autosize").autosize()
  
  #----------- END autosize CODE -------------------------
  
  #----------- BEGIN inputlimiter CODE -------------------------
  $("#limiter").inputlimiter
    limit: 140
    remText: "You only have %n character%s remaining..."
    limitText: "You're allowed to input %n character%s into this field."

  
  #----------- END inputlimiter CODE -------------------------
  
  #----------- BEGIN tagsInput CODE -------------------------
  $("#tags").tagsInput()
  
  #----------- END tagsInput CODE -------------------------
  
  #----------- BEGIN chosen CODE -------------------------
  $(".chzn-select").chosen()
  $(".chzn-select-deselect").chosen allow_single_deselect: true
  
  #----------- END chosen CODE -------------------------
  
  #----------- BEGIN spinner CODE -------------------------
  $("#spin1").spinner()
  $("#spin2").spinner
    step: 0.01
    numberFormat: "n"

  $("#spin3").spinner
    culture: "en-US"
    min: 5
    max: 2500
    step: 25
    start: 1000
    numberFormat: "C"

  
  #----------- END spinner CODE -------------------------
  
  #----------- BEGIN uniform CODE -------------------------
  $(".uniform").uniform()
  
  #----------- END uniform CODE -------------------------
  
  #----------- BEGIN validVal CODE -------------------------
  $("#validVal").validVal()
  
  #----------- END validVal CODE -------------------------
  
  #----------- BEGIN colorpicker CODE -------------------------
  $("#cp1").colorpicker format: "hex"
  $("#cp2").colorpicker()
  $("#cp3").colorpicker()
  $("#cp4").colorpicker().on "changeColor", (ev) ->
    $("#colorPickerBlock").css "background-color", ev.color.toHex()

  
  #----------- END colorpicker CODE -------------------------
  
  #----------- BEGIN datepicker CODE -------------------------
  $("#dp1").datepicker format: "mm-dd-yyyy"
  $("#dp2").datepicker()
  $("#dp3").datepicker()
  $("#dp3").datepicker()
  $("#dpYears").datepicker()
  $("#dpMonths").datepicker()
  startDate = new Date(2012, 1, 20)
  endDate = new Date(2012, 1, 25)
  $("#dp4").datepicker().on "changeDate", (ev) ->
    if ev.date.valueOf() > endDate.valueOf()
      $("#alert").show().find("strong").text "The start date can not be greater then the end date"
    else
      $("#alert").hide()
      startDate = new Date(ev.date)
      $("#startDate").text $("#dp4").data("date")
    $("#dp4").datepicker "hide"

  $("#dp5").datepicker().on "changeDate", (ev) ->
    if ev.date.valueOf() < startDate.valueOf()
      $("#alert").show().find("strong").text "The end date can not be less then the start date"
    else
      $("#alert").hide()
      endDate = new Date(ev.date)
      $("#endDate").text $("#dp5").data("date")
    $("#dp5").datepicker "hide"

  
  #----------- END datepicker CODE -------------------------
  
  #----------- BEGIN daterangepicker CODE -------------------------
  $("#reservation").daterangepicker()
  $("#reportrange").daterangepicker
    ranges:
      Today: [moment(), moment()]
      Yesterday: [moment().subtract("days", 1), moment().subtract("days", 1)]
      "Last 7 Days": [moment().subtract("days", 6), moment()]
      "Last 30 Days": [moment().subtract("days", 29), moment()]
      "This Month": [moment().startOf("month"), moment().endOf("month")]
      "Last Month": [moment().subtract("month", 1).startOf("month"), moment().subtract("month", 1).endOf("month")]
  , (start, end) ->
    $("#reportrange span").html start.format("MMMM D, YYYY") + " - " + end.format("MMMM D, YYYY")

  
  #----------- END daterangepicker CODE -------------------------
  
  #----------- BEGIN timepicker CODE -------------------------
  $(".timepicker-default").timepicker()
  $(".timepicker-24").timepicker
    minuteStep: 1
    showSeconds: true
    showMeridian: false

  
  #----------- END timepicker CODE -------------------------
  
  #----------- BEGIN toggleButtons CODE -------------------------
  $(".make-switch").bootstrapSwitch()
  
  #----------- END toggleButtons CODE -------------------------
  
  #----------- BEGIN dualListBox CODE -------------------------
  $.configureBoxes()

#----------- END dualListBox CODE -------------------------
formValidation = ->
  "use strict"
  
  #----------- BEGIN validationEngine CODE -------------------------
  $("#popup-validation").validationEngine()
  
  #----------- END validationEngine CODE -------------------------
  
  #----------- BEGIN validate CODE -------------------------
  $("#inline-validate").validate
    rules:
      required: "required"
      email:
        required: true
        email: true

      date:
        required: true
        date: true

      url:
        required: true
        url: true

      password:
        required: true
        minlength: 5

      confirm_password:
        required: true
        minlength: 5
        equalTo: "#password"

      agree: "required"
      minsize:
        required: true
        minlength: 3

      maxsize:
        required: true
        maxlength: 6

      minNum:
        required: true
        min: 3

      maxNum:
        required: true
        max: 16

    errorClass: "help-block col-lg-6"
    errorElement: "span"
    highlight: (element, errorClass, validClass) ->
      $(element).parents(".form-group").removeClass("has-success").addClass "has-error"

    unhighlight: (element, errorClass, validClass) ->
      $(element).parents(".form-group").removeClass("has-error").addClass "has-success"

  $("#block-validate").validate
    rules:
      required2: "required"
      email2:
        required: true
        email: true

      date2:
        required: true
        date: true

      url2:
        required: true
        url: true

      password2:
        required: true
        minlength: 5

      confirm_password2:
        required: true
        minlength: 5
        equalTo: "#password2"

      agree2: "required"
      digits:
        required: true
        digits: true

      range:
        required: true
        range: [5, 16]

    errorClass: "help-block"
    errorElement: "span"
    highlight: (element, errorClass, validClass) ->
      $(element).parents(".form-group").removeClass("has-success").addClass "has-error"

    unhighlight: (element, errorClass, validClass) ->
      $(element).parents(".form-group").removeClass("has-error").addClass "has-success"


#----------- END validate CODE -------------------------
formWizard = ->
  "use strict"
  
  #----------- BEGIN uniform CODE -------------------------
  $("#fileUpload").uniform()
  
  #----------- END uniform CODE -------------------------
  
  #----------- BEGIN plupload CODE -------------------------
  $("#uploader").pluploadQueue
    runtimes: "html5,html4"
    url: "form-wysiwyg.html"
    max_file_size: "128kb"
    unique_names: true
    filters: [
      title: "Image files"
      extensions: "jpg,gif,png"
    ]

  
  #----------- END plupload CODE -------------------------
  
  #----------- BEGIN formwizard CODE -------------------------
  $("#wizardForm").formwizard
    formPluginEnabled: true
    validationEnabled: true
    focusFirstInput: true
    formOptions:
      beforeSubmit: (data) ->
        $.gritter.add
          
          # (string | mandatory) the heading of the notification
          title: "data sent to the server"
          
          # (string | mandatory) the text inside the notification
          text: $.param(data)
          sticky: false

        false

      dataType: "json"
      resetForm: true

    validationOptions:
      rules:
        server_host: "required"
        server_name: "required"
        server_user: "required"
        server_password: "required"
        table_prefix: "required"
        table_collation: "required"
        username:
          required: true
          minlength: 3

        usermail:
          required: true
          email: true

        pass:
          required: true
          minlength: 6

        pass2:
          required: true
          minlength: 6
          equalTo: "#pass"

      errorClass: "help-block"
      errorElement: "span"
      highlight: (element, errorClass, validClass) ->
        $(element).parents(".form-group").removeClass("has-success").addClass "has-error"

      unhighlight: (element, errorClass, validClass) ->
        $(element).parents(".form-group").removeClass("has-error").addClass "has-success"


#----------- END formwizard CODE -------------------------
formWysiwyg = ->
  "use strict"
  
  #----------- BEGIN wysihtml5 CODE -------------------------
  $("#wysihtml5").wysihtml5()
  
  #----------- END wysihtml5 CODE -------------------------
  
  #----------- BEGIN Markdown.Editor CODE -------------------------
  converter = Markdown.getSanitizingConverter()
  editor = new Markdown.Editor(converter)
  editor.run()
  
  #----------- END Markdown.Editor CODE -------------------------
  
  #----------- BEGIN cleditor CODE -------------------------
  editor = $("#cleditor").cleditor(
    width: "100%"
    height: "100%"
  )[0].focus()
  $(window).resize()
  $(window).resize ->
    $win = $("#cleditorDiv")
    $("#cleditor").width($win.width() - 24).height($win.height() - 24).offset
      left: 15
      top: 15

    editor.refresh()


#----------- END cleditor CODE -------------------------
metisCalendar = ->
  "use strict"
  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()
  hdr = {}
  if $(window).width() <= 767
    hdr =
      left: "title"
      center: ""
      right: "prev,today,month,agendaWeek,agendaDay,next"
  else
    hdr =
      left: ""
      center: "title"
      right: "prev,today,month,agendaWeek,agendaDay,next"
  initDrag = (e) ->
    
    # create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
    # it doesn't need to have a start or end
    eventObject =
      title: $.trim(e.text()) # use the element's text as the event title
      className: $.trim(e.children("span").attr("class")) # use the element's children as the event class

    
    # store the Event Object in the DOM element so we can get to it later
    e.data "eventObject", eventObject
    
    # make the event draggable using jQuery UI
    e.draggable
      zIndex: 999
      revert: true # will cause the event to go back to its
      revertDuration: 0 #  original position after the drag


  addEvent = (title, priority) ->
    title = (if title.length is 0 then "Untitled Event" else title)
    priority = (if priority.length is 0 then "label label-default" else priority)
    html = $("<li class=\"external-event\"><span class=\"" + priority + "\">" + title + "</span></li>")
    jQuery("#external-events").append html
    initDrag html

  
  # initialize the external events
  #     -----------------------------------------------------------------
  $("#external-events li.external-event").each ->
    initDrag $(this)

  $("#add-event").click ->
    title = $("#title").val()
    priority = $("input:radio[name=priority]:checked").val()
    addEvent title, priority

  
  # initialize the calendar
  #     -----------------------------------------------------------------
  $("#calendar").fullCalendar
    header: hdr
    buttonText:
      prev: "<i class=\"icon-chevron-left\"></i>"
      next: "<i class=\"icon-chevron-right\"></i>"

    editable: true
    droppable: true # this allows things to be dropped onto the calendar !!!
    drop: (date, allDay) -> # this function is called when something is dropped
      
      # retrieve the dropped element's stored Event Object
      originalEventObject = $(this).data("eventObject")
      
      # we need to copy it, so that multiple events don't have a reference to the same object
      copiedEventObject = $.extend({}, originalEventObject)
      
      # assign it the date that was reported
      copiedEventObject.start = date
      copiedEventObject.allDay = allDay
      
      # render the event on the calendar
      # the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
      $("#calendar").fullCalendar "renderEvent", copiedEventObject, true
      
      # is the "remove after drop" checkbox checked?
      
      # if so, remove the element from the "Draggable Events" list
      $(this).remove()  if $("#drop-remove").is(":checked")

    windowResize: (event, ui) ->
      $("#calendar").fullCalendar "render"

metisFile = ->
  "use strict"
  
  #----------- BEGIN elfinder CODE -------------------------
  # connector URL (REQUIRED)
  # lang: 'de',             // language (OPTIONAL)
  elf = $("#elfinder").elfinder(url: "assets/elfinder-2.0-rc1/php/connector.php").elfinder("instance")

#----------- END elfinder CODE -------------------------
metisMaps = ->
  "use strict"
  map1 = undefined
  map2 = undefined
  map3 = undefined
  map4 = undefined
  map5 = undefined
  map6 = undefined
  path = undefined
  map1 = new GMaps(
    el: "#gmaps-basic"
    lat: -12.043333
    lng: -77.028333
    zoomControl: true
    zoomControlOpt:
      style: "SMALL"
      position: "TOP_LEFT"

    panControl: false
    streetViewControl: false
    mapTypeControl: false
    overviewMapControl: false
  )
  map2 = new GMaps(
    el: "#gmaps-marker"
    lat: -12.043333
    lng: -77.028333
  )
  map2.addMarker
    lat: -12.043333
    lng: -77.03
    title: "Lima"
    details:
      database_id: 42
      author: "HPNeo"

    click: (e) ->
      console.log e  if console.log
      alert "You clicked in this marker"

    mouseover: (e) ->
      console.log e  if console.log

  map2.addMarker
    lat: -12.042
    lng: -77.028333
    title: "Marker with InfoWindow"
    infoWindow:
      content: "<p>HTML Content</p>"

  map3 = new GMaps(
    el: "#gmaps-geolocation"
    lat: -12.043333
    lng: -77.028333
  )
  GMaps.geolocate
    success: (position) ->
      map3.setCenter position.coords.latitude, position.coords.longitude

    error: (error) ->
      alert "Geolocation failed: " + error.message

    not_supported: ->
      alert "Your browser does not support geolocation"

    always: ->

  
  #alert("Done!");
  map4 = new GMaps(
    el: "#gmaps-polylines"
    lat: -12.043333
    lng: -77.028333
    click: (e) ->
      console.log e
  )
  path = [[-12.044012922866312, -77.02470665341184], [-12.05449279282314, -77.03024273281858], [-12.055122327623378, -77.03039293652341], [-12.075917129727586, -77.02764635449216], [-12.07635776902266, -77.02792530422971], [-12.076819390363665, -77.02893381481931], [-12.088527520066453, -77.0241058385925], [-12.090814532191756, -77.02271108990476]]
  map4.drawPolyline
    path: path
    strokeColor: "#131540"
    strokeOpacity: 0.6
    strokeWeight: 6

  map5 = new GMaps(
    el: "#gmaps-route"
    lat: -12.043333
    lng: -77.028333
  )
  map5.drawRoute
    origin: [-12.044012922866312, -77.02470665341184]
    destination: [-12.090814532191756, -77.02271108990476]
    travelMode: "driving"
    strokeColor: "#131540"
    strokeOpacity: 0.6
    strokeWeight: 6

  map6 = new GMaps(
    el: "#gmaps-geocoding"
    lat: -12.043333
    lng: -77.028333
  )
  $("#geocoding_form").submit (e) ->
    e.preventDefault()
    GMaps.geocode
      address: $("#address").val().trim()
      callback: (results, status) ->
        if status is "OK"
          latlng = results[0].geometry.location
          map6.setCenter latlng.lat(), latlng.lng()
          map6.addMarker
            lat: latlng.lat()
            lng: latlng.lng()



metisTable = ->
  "use strict"
  
  #----------- BEGIN TABLESORTER CODE -------------------------
  
  # required jquery.tablesorter.min.js
  $(".sortableTable").tablesorter()
  
  #----------- END TABLESORTER CODE -------------------------
  
  #----------- BEGIN datatable CODE -------------------------
  $("#dataTable").dataTable
    sDom: "<'pull-right'l>t<'row'<'col-lg-6'f><'col-lg-6'p>>"
    sPaginationType: "bootstrap"
    oLanguage:
      sLengthMenu: "Show _MENU_ entries"

  
  #----------- END datatable CODE -------------------------
  
  #----------- BEGIN action table CODE -------------------------
  $("#actionTable button.remove").on "click", ->
    $(this).closest("tr").remove()

  $("#actionTable button.edit").on "click", ->
    $("#editModal").modal show: true
    val1 = $(this).closest("tr").children("td").eq(1)
    val2 = $(this).closest("tr").children("td").eq(2)
    val3 = $(this).closest("tr").children("td").eq(3)
    $("#editModal #fName").val val1.html()
    $("#editModal #lName").val val2.html()
    $("#editModal #uName").val val3.html()
    $("#editModal #sbmtBtn").on "click", ->
      val1.html $("#editModal #fName").val()
      val2.html $("#editModal #lName").val()
      val3.html $("#editModal #uName").val()



#----------- END action table CODE -------------------------
progRess = ->
  window.prettyPrint and prettyPrint()
  $.each $(".progress .progress-bar"), ->
    $(this).animate width: $(this).attr("aria-valuenow") + "%"
    $(this).popover
      placement: "bottom"
      title: "Source"
      content: @outerHTML


metisButton = ->
  window.prettyPrint and prettyPrint()
  $.each $(".inner a.btn"), ->
    $(this).popover
      placement: "bottom"
      title: @innerHTML
      content: @outerHTML
      trigger: "hover"


metisSortable = ->
  $(".inner .row").sortable {}
$ ->
  "use strict"
  $("a[href=#]").on "click", (e) ->
    e.preventDefault()

  $("a[data-toggle=tooltip]").tooltip()
  $("a[data-tooltip=tooltip]").tooltip()
  $(".minimize-box").on "click", (e) ->
    e.preventDefault()
    $icon = $(this).children("i")
    if $icon.hasClass("icon-chevron-down")
      $icon.removeClass("icon-chevron-down").addClass "icon-chevron-up"
    else $icon.removeClass("icon-chevron-up").addClass "icon-chevron-down"  if $icon.hasClass("icon-chevron-up")

  $(".close-box").click ->
    $(this).closest(".box").hide "slow"

  $("#changeSidebarPos").on "click", (e) ->
    $("body").toggleClass "hide-sidebar"

  $("li.accordion-group > a").on "click", (e) ->
    $(this).children("span").children("i").toggleClass "icon-angle-down"

