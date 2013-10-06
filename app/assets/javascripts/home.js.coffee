# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

update_datatables = ->
  # Init DataTables
  oTable = $(".datatable").dataTable
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sAjaxSource: gon.students_url
    bProcessing: true,
    oLanguage:
      sUrl: "/datatable_spanish.txt"
    fnDrawCallback: (oSettings) ->
      
      # create links to see more
      $("table.datatable tr").find('td:first').each ->
        url = gon.admin_student_log_url.replace(/replace_me/, $(this).html())
        $(this).html( "<a href='#{url}'> #{$(this).html()} </a>" )
        $(this).editable("disable")

      # seamless edition
      $("table.datatable td").editable gon.update_table,
        callback: (sValue, y) ->
          aPos = oTable.fnGetPosition(this)
          oTable.fnUpdate sValue, aPos[0], aPos[1]
          # state needs a reload to work
          if $(this).attr('id') == 'state'
            location.reload()

        submitdata: (value, settings) ->
          row_id: $(@parentNode).find('td:first').html()[28] # TODO: find a better way to extract the id
          column: oTable.fnGetPosition(this)[2]

        data: (data) ->
          $.trim(data)

        height: "25px"
        # sPaginationType: "bootstrap"

$(document).ready ->
  if $(".datatable").length > 0
    update_datatables()

