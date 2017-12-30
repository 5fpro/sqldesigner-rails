$(function() {
  $('table.js-datatable').each(function() {
    var el = $(this)
    data = JSON.parse(el.attr('data-table-options') || '{}')
    el.DataTable(data);
  })
})

