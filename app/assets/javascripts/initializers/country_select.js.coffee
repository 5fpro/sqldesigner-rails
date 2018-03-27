init_country_select = (dom) ->
  $(dom).find('.js-country-select').each ->
    me = $(@)
    append = '<input type="hidden" name="' + me.attr('name') + '" value="' + me.val() + '" id="' + me.attr('id') + '_code" />'
    me.after(append)
    ori_val = me.val()
    me.val('')
    me.attr('name', '')
    me.countrySelect($(@).data('country-select') || {})
    if ori_val != ''
      me.countrySelect('selectCountry', ori_val)
$ ->
  init_country_select('body')
