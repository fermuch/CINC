# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  # Init DataTables 
  oTable = $(".datatable").dataTable
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sAjaxSource: gon.students_url
    bProcessing: true,
    oLanguage:
      sUrl: "/datatable_spanish.txt"
    # sPaginationType: "bootstrap"
    
  # Apply the jEditable handlers to the table 
  $("td", oTable.fnGetNodes()).editable gon.update_table,
    callback: (sValue, y) ->
      aPos = oTable.fnGetPosition(this)
      oTable.fnUpdate sValue, aPos[0], aPos[1]
      # state needs a reload to work
      if $(this).attr('id') == 'state'
        location.reload()

    submitdata: (value, settings) ->
      row_id: @parentNode.getAttribute("id")
      column: oTable.fnGetPosition(this)[2]

    data: (data) ->
      $.trim(data)
    height: "25px"