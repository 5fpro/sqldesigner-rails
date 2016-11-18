#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require unicorn
#= require_self
#= require_tree ./admin

# admin menu auto active
$ ->
  $("li.submenu li.active").each ->
    $(this).parents("li.submenu").addClass("open active")
