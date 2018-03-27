init_intl_tel_inpupt = (dom) ->
  $(dom).find('.js-intl-tel').each ->
    $(@).intlTelInput($(@).data('intl-tel') || {})
$ ->
  init_intl_tel_inpupt('body')
