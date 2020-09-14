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
      }        
    });    
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
          $("#tasks-list-"+projectId).prepend(partialTask)
        }    
      })
      .fail(function(errorTaskResponse) {
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
    if (newTaskName == "") {        
      $("#task-edit-control-label-id-"+taskId).text("Task name must be filled out")
    }else if(newTaskName.length>255){ 
      $("#task-edit-control-label-id-"+taskId).text("Task name is too long (maximum is 255 characters)")
    }else {
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
      })
    }  
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
  $(document).on('click', '.deadline-task', function() {
    var taskId =this.dataset.id
    $("#task-deadline-edit-id-" + taskId).toggle();
    $("#task-deadline-update-id-" + taskId).toggle();    
  });
  $(document).on('click', '.task-deadline-update', function() {
    var taskId = this.dataset.id;
    var projectId = this.dataset.projectid;
    var updateTaskDeadline = $("#task-deadline-edit-id-"+taskId).val();
    const currentDate = $('.current-date').text()
    if (currentDate >= updateTaskDeadline) {        
      $("#task-deadline-expired-id-"+taskId).text("Set upcoming date").css("color", "red")
    }else{
      $.ajax({
        url: '/projects/'+projectId+'/tasks/'+taskId,
        type: 'PATCH',
        data: {task: {deadline: updateTaskDeadline}},
        success: function(updateTask) {
          if (currentDate < updateTaskDeadline) {
            $("#task-deadline-expired-id-"+taskId).text("In progress").css("color", "green")
          }
        }        
      })
      .fail(function(errorTaskUpdate) {
        alert(errorTaskUpdate.responseJSON.name)
      });
    }
  });