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
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  $("#formButton").click(function() {
      $(".new_project").toggle();    
    });
  $(".new_project").show("slow");/*remove afterfinish work*/
  $(document).on('click', '.delete_project', function() {
    var id = this.dataset.id
    $.ajax({
      url: '/projects/' + id,
      type: 'DELETE',
      success: function(result) {
        alert("success delete application.js"+"#project-"+ id); 
        $("#project-"+ id).remove("#project-"+ id);        
      }      
    });
  });
  $(document).on('click', '.edit_project', function() {
    var dataset_id =this.dataset.id
    $("#project_input_" + dataset_id).toggle();
    $("#form_project_name_" + dataset_id).toggle();    
  });
  $(document).on('click', '.update_project', function() {
    var dataset_id = this.dataset.id;
    var new_project_name = $("#project_edit_"+dataset_id).val()/*id класс класс в стили*/
    $.ajax({
      url: '/projects/' + dataset_id,
      type: 'PATCH',
      data: {project: {name: new_project_name}},
      success: function(update_data) {
        $("#project_input_" + dataset_id).toggle();
        $("#project_name_" + dataset_id).text(update_data.name);/* style="display: block;"*/        
        $("#form_project_name_" + dataset_id).toggle();/**/ 
      }        
    });
  });
  $(document).on('click', '.new_task', function() {    
    var dataset_id = this.dataset.id;/*project.id*/
    var new_task_name = $("#project_task_"+dataset_id).val();/*update_data.name*/
    $.ajax({
      url: '/projects/' + dataset_id +'/tasks',
      type: 'POST',
      data: {task: {name: new_task_name}},
      success: function(new_data_name) {
        alert("success TASK create application.js rafresh homepage");
        
        /*обновить форму отправки по класу val окей*/
      }        
    });
  });  
});
/*      var new_task = '<span class="form_task_name">' + '<div>' + new_data_name + '<div>' + '</span>';
        $("#task-"+ dataset_id).append(new_task);

var new_task = '<span class="form_task_name">' + '<div>' + new_task_name + '<div>' + '</span>' *//*не окончен*/
/*

var new_task = '<span class="task_input"> id="task_input_' + dataset_id + '">'  + new_task_name + '</span>'
  '<input class="task_edit" id="task_edit_' + dataset_id + '" value="'+ new_task_name + '"></input>'
  '<div class="update_task" data-id="' + dataset_id + '">UPDATE</div>'
*/    
/*project.name="string" project.save t.string :name  params.require(:project).permit(:name) #разрешение на редактирование*/
/*
$(document).on('click', '.update_project', function() {
    var id = this.dataset.id;
    var update_data=$(".name").text();
    var update_name = $(text_area);
    $.ajax({
      url: '/projects/' + id,
      type: 'PATCH',
      data: {name: input field},
      success: function(update_data) {
        alert("success update application.js"+"#project-"+ id);
        data = JSON.toString(update_name);               
      }      
    });
  });
});
$("body").on("click", ".remove-button", function () {
      $(this).parent().remove();
    });
  $("body").on("click", ".create-button", function () {
      var countPlayers = $('.example li').length;
      var player = '<li>Игрок ' + (countPlayers+1)  + 
      ' <a href="javascript: return false;" class="remove-button right">Удалить</a></li>';
      $('.example').append(player); 
  });  
*/
