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
  /*  ----------------------------- drag and drop----------------------------*/  
  $('.tasks_tbody').sortable({
    update: function(e, ui){
      $.ajax({
        url: $(this).data("url"),
        type:'PATCH',
        data:$(this).sortable('serialize'),
      }
      );
    },
    handle: ".task_priority_drag_and_drop"    
  });  
  /*--------------------------------------- projects -------------------------------------*/
  $("#formButton").click(function() {
      $(".project-create-form").toggle();    
    });
  $(".project-create-form").show("slow");//remove afterfinish work
  /*--------------------------------------- create projects -------------------------------------*/
  $(document).on('click', '.project-create-btn', function() {    
    var newProjectName = $(".project-input-form").val()
    if (newProjectName == "") {        
      $(".project-control-label").text("Project name must be filled out")
    }else if(newProjectName.length>80){ 
      $(".project-control-label").text("Project name is too long (maximum is 80 characters)")
    }else { 
      $.ajax({
        url: '/projects',
        type: 'POST',
        data: {project: {name: newProjectName}},
      success: function(partialProjectsList) {
        $(".project-control-label").text("")
        $('.project-input-form').val('')
        $(".feed_itemsprojects_list").append(partialProjectsList)
        }
      })
      .fail(function(errorProjectResponse) {
        alert(errorProjectResponse.responseJSON.name)      
      })            
    }      
  });
  /*-------------------------------------- delete_project  -------------------------------------*/
  $(document).on('click', '.delete_project', function() {
    var id = this.dataset.id
    $.ajax({
      url: '/projects/' + id,
      type: 'DELETE',
      success: function(result) {
        $("#project-"+ id).remove("#project-"+ id);        
      }
    });
  });
  
  /*  ----------------------------- update_project ---------------------------------------------*/  

  $(document).on('click', '.edit_project', function() {
    var projectId =this.dataset.id
    $("#project_input_" + projectId).toggle();
    $("#form_project_name_" + projectId).toggle();    
  });

  $(document).on('click', '.update_project', function() {
    var projectId = this.dataset.id;
    var newProjectName = $("#project_edit_"+projectId).val()
    $.ajax({
      url: '/projects/' + projectId,
      type: 'PATCH',
      data: {project: {name: newProjectName}},
      success: function(updateProject) {
        $("#project_input_" + updateProject.id).toggle();
        $("#project_name_" + updateProject.id).text(updateProject.name);
        $("#form_project_name_" + updateProject.id).toggle(); 
      }        
    })
    .fail(function(errorProjectUpdate) { 
      alert(errorProjectUpdate.responseJSON.name)
    })
  });  
  
  /*  ----------------------------- new_task ---------------------------------------------*/  
  $(document).on('click', '.new_task', function() {
    var projectId = this.dataset.id;
    var newTaskName = $("#project_task_"+projectId).val()
    if (newTaskName == "") {        
      $("#project-id-new-task-error-"+projectId).text("Task name must be filled out")
    }else if(newTaskName.length>255){ 
      $("#project-id-new-task-error-"+projectId).text("Task name is too long (maximum is 255 characters)")
    }else {
      $.ajax({
        url: '/projects/' + projectId +'/tasks',
        type: 'POST',
        data: {task: {name: newTaskName}},
        success: function(partialTask) {
          $("#project-id-new-task-error-"+projectId).text("")
          $("#project_task_"+projectId).val('')
          $("#project_tasks-"+projectId).append(partialTask)
        }    
      })
      .fail(function(errorTaskResponse) {
        console.log(errorTaskResponse)
        console.dir(errorTaskResponse) 
        alert(errorTaskResponse.responseJSON.name)      
      })
    }
  });

  /*  ----------------------------- update_task ---------------------------------------------*/  
  $(document).on('click', '.edit_task', function() {
    var taskId =this.dataset.id
    $("#task_name_" + taskId).toggle();
    $("#task_input_" + taskId).toggle();    
  });
  $(document).on('click', '.update_task', function() {
    var taskId = this.dataset.id;
    var projectId = this.dataset.projectid;
    var newTaskName = $("#task_edit_"+taskId).val();    
    $.ajax({
      url: '/projects/'+projectId+'/tasks/'+taskId,
      type: 'PATCH',
      data: {task: {name: newTaskName}},
      success: function(updateTask) {
        $("#task_name_" + updateTask.id).text(updateTask.name);
        $("#task_input_" + updateTask.id).toggle();        
        $("#task_name_" + updateTask.id).toggle();    
      }        
    })
    .fail(function(errorTaskUpdate) { 
      alert(errorTaskUpdate.responseJSON.name)
    });
  });

  /*-------------------------- delete TASK ---------------------------*/
  $(document).on('click', '.delete_task', function() {    
    var task_id = this.dataset.id;
    var project_id = this.dataset.projectid;    
    $.ajax({
      url: '/projects/'+project_id+'/tasks/'+task_id,
      type: 'DELETE',
      success: function(result) {        
        $("#task_"+ task_id).remove("#task_"+ task_id);
      }      
    });
  });

  /*  ----------------------------- updateTaskDeadline ----------------------------*/  
  /*
  $(document).on('click', '.edit_task', function() {
    var taskId =this.dataset.id
    $("#task_name_" + taskId).toggle();
    $("#task_input_" + taskId).toggle();    
  });
  */
  /* $(document).ready(function() { need loop on task.count event and check by id------------*/
  var currentDate = $('.current-date').text()
  var lastTask = $('.last-task').text()
  for (var i = 0; i < lastTask; i++) {
    var updateTaskDeadline = $("#task-deadline-edit-id-"+i).val()
    if (currentDate > updateTaskDeadline) {
      $("#task-deadline-expired-id-"+i).text("Expired").css("color", "red")
    } else if(currentDate < updateTaskDeadline){
      $("#task-deadline-expired-id-"+i).text("inprogress").css("color", "green")
    } 
  }

  $(document).on('click', '.task-deadline-update', function() {
    var taskId = this.dataset.id;
    var projectId = this.dataset.projectid;
    var updateTaskDeadline = $("#task-deadline-edit-id-"+taskId).val();
    const currentDate = $('.current-date').text()
    if (currentDate > updateTaskDeadline) {        
      $("#task-deadline-expired-id-"+taskId).text("Expired").css("color", "red")
    }else {
      $.ajax({
        url: '/projects/'+projectId+'/tasks/'+taskId,
        type: 'PATCH',
        data: {task: {deadline: updateTaskDeadline}},
        success: function(updateTask) {
          if (currentDate < updateTaskDeadline) {
            $("#task-deadline-expired-id-"+taskId).text("inprogress").css("color", "green")
          } else if(currentDate > updateTaskDeadline){
            $("#task-deadline-expired-id-"+taskId).text("Expired").css("color", "red")
          }
          console.log(updateTask)
          //2020-09-04 10:41:06.362186
          /*$("#task_name_" + updateTask.id).text(updateTask.name);
          $("#task_input_" + updateTask.id).toggle();        
          $("#task_name_" + updateTask.id).toggle();    */
        }        
      })
      .fail(function(errorTaskUpdate) { 
        alert(errorTaskUpdate)//errorTaskUpdate.responseJSON.name)
      });
    }
  });

  /*  ----------------------------- checkbox----------------------------*/  
  $(document).on('click', '.status', function() {
    var taskId = this.dataset.id;
    var projectId = this.dataset.projectid;
    var newTaskStatus = document.querySelector("#task_status_"+taskId).checked
    $.ajax({
      url: '/projects/'+projectId+'/tasks/'+taskId,
      type: 'PATCH',
      data: {task: {status: newTaskStatus}},
      success: function(updateData) {        
        console.dir("update data")
        console.dir(updateData)
        console.log(updateData)
      }        
    });    
  });
});