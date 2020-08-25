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
//= require jquery-ui/widget
//= require jquery-ui/sortable
//= require jquery_ujs
//= require turbolinks
//= require_tree .
/**/
$(document).ready(function() {
  
  $('.tasks_tbody').sortable({
    update: function(e, ui){
      /*Rails.*/
      $.ajax({
        url: $(this).data("url"),
        type:'PATCH',
        data:$(this).sortable('serialize'),
      });
    }
  });

  
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
    var new_project_name = $("#project_edit_"+dataset_id).val()
    $.ajax({
      url: '/projects/' + dataset_id,
      type: 'PATCH',
      data: {project: {name: new_project_name}},
      success: function(update_data) {
        $("#project_input_" + dataset_id).toggle();
        $("#project_name_" + dataset_id).text(update_data.name);
        $("#form_project_name_" + dataset_id).toggle(); 
      }        
    });
  });
  /*TASK*/
  $(document).on('click', '.edit_task', function() {
    var task_id =this.dataset.id
    $("#task_name_" + task_id).toggle();
    $("#task_input_" + task_id).toggle();    
  });
  $(document).on('click', '.update_task', function() {
    var task_id = this.dataset.id;
    var project_id = this.dataset.projectid;
    var new_task_name = $("#task_edit_"+task_id).val();    
    $.ajax({
      url: '/projects/'+project_id+'/tasks/'+task_id,
      type: 'PATCH',
      data: {task: {name: new_task_name}},
      success: function(update_data) {
        $("#task_name_" + update_data.id).text(update_data.name);
        $("#task_input_" + update_data.id).toggle();        
        $("#task_name_" + update_data.id).toggle();    
      }        
    });
  });
  $(document).on('click', '.new_task', function() {    
    var project_id = this.dataset.id;/*project.id*/
    var new_task_name = $("#project_task_"+project_id).val()
    $.ajax({
      url: '/projects/' + project_id +'/tasks',
      type: 'POST',
      data: {task: {name: new_task_name}},
      success: function(new_data_name) {        
        $("#project_tasks-"+project_id).append(new_data_name);
        $("#project_task_"+project_id).val('');
      }        
    });
  });
  $(document).on('click', '.delete_task', function() {    
    var task_id = this.dataset.id;
    var project_id = this.dataset.projectid;    
    $.ajax({
      url: '/projects/'+project_id+'/tasks/'+task_id,
      type: 'DELETE',
      success: function(result) {        
        $("#task_"+ task_id).remove("#task_"+ task_id);/*task_id_*/
      }      
    });
  });  
});
/* url: /tasks/sort */ /*/projects/:project_id/tasks/:id*/
      /*console.log($(this).sortable('serialize'));*/
      /*task[]=51&task[]=50&task[]=58*/