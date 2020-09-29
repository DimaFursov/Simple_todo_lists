// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/widget
//= require jquery-ui/widgets/sortable
//= require jquery-ui/widgets/mouse
//= require jquery-ui/widgets/draggable
//= require jquery-ui/widgets/droppable
//= require jquery-ui/widgets/resizable
//= require jquery-ui/widgets/selectable
//= require turbolinks
//= require_tree .
/**/

/* ----------------------------------------------------------------------------------------------*/
$(document).ready(function() {
  /*  + add_TODO_LIST btn  */
  $("#add-todo-list").click(function() {
      $(".project-create-form").toggle();    
    });
  //$(".project-create-form").show("slow");// -  ------------- remove afterfinish work
  /*  ----------------------------- TASK drag and drop ----------------------------------*/
  $(".tasks_tbody").sortable({
    update: function(e, ui){
      
      $.ajax({
        url: $(this).data("url"),
        type:'PATCH',
        data:$(this).sortable('serialize'),
      });
    },
    handle: ".task_priority_drag_and_drop"    
  });
  /* ----------------------------------------------------------------------------------------------*/  
});
