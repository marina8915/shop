#= require active_admin/base
#= require tinymce

$(document).ready ->
  tinyMCE.init
    mode: 'textareas'
    editor_selector: 'tinymce'
  return
