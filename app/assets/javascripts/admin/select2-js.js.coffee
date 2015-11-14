#= require select2

init_select2 = (dom) ->
  $(dom).find("select[data-select]").each ->
    $(@).select2({ "width": $(@).data("width") || "80%", "allowClear": true })
  $(dom).find("[data-select=tags]").each ->
    opts = { "width": $(@).data("width") || "80%" }
    opts.tokenSeparators = [",", " "]
    opts.tags = true
    $(@).select2(opts)
