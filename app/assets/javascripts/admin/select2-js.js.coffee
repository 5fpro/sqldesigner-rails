init_select2 = (dom) ->
  $(dom).find("select.js-select2").each ->
    first_otp = $($(@).find('option')[0])
    allowClear = first_otp.val() == ''
    $(@).select2
      width: $(@).data("width") || "80%"
      allowClear: allowClear
      placeholder: if allowClear then first_otp.html() else null
  $(dom).find("select.js-select2-tags").each ->
    opts =
      tokenSeparators: [',', ' ']
      tags: true
      with: '80%'
    $(@).attr('multiple', true).select2(opts)

$ ->
  init_select2("body")
