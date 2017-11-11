init_select2 = (dom) ->
  $(dom).find("select.js-select2").each ->
    $(@).select2({ "width": $(@).data("width") || "80%", "allowClear": true })
  $(dom).find("select.js-select2-tags").each ->
    opts =
      tokenSeparators: [',', ' ']
      tags: true
      with: '80%'
    console.log(opts)
    $(@).attr('multiple', true).select2(opts)

$ ->
  init_select2("body")
