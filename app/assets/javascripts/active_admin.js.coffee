#= require active_admin/base

$( ->
  dateFormat = $( ".datepicker" ).datepicker( "option", "dateFormat" )
  $( ".datepicker" ).datepicker( "option", "dateFormat", 'dd/mm/yy' )
)

