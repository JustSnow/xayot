//= require jquery
//= require jquery_ujs
//= require select2
//= require select2_locale_ru
//= require_self
//= require twitter/bootstrap
//= require jquery.ui.all
//= require jquery.ui.nestedSortable
//= require sortable_tree/initializer
//= require ckeditor/init
//= require jquery-fileupload

$(document).ready(function(){
  $(document).on('click', '.clickTabs a', function(e) {
    e.preventDefault();
    $(this).tab('show');
  });

  if ($('#menu_post_id').length > 0) $('#menu_post_id').select2({'width': 'element'});
  if ($('#menu_category_id').length > 0) $('#menu_category_id').select2({'width': 'element'});
});
