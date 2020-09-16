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
        $(".items-projects-list").append(partialProjectsList)
        }
      })
      .fail(function(errorProjectResponse) {
        alert(errorProjectResponse.responseJSON.name)      
      })            
    }      
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
    if (newProjectName == "") {        
      $("#project-update-id-error-" + projectId).text("Project name must be filled out")
    }else if(newProjectName.length>80){ 
      $("#project-update-id-error-" + projectId).text("Project name is too long (maximum is 80 characters)")
    }else { 
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
    }  
  });
  /*-------------------------------------- delete_project  -------------------------------------*/
  $(document).on('click', '.delete_project', function() {
    var confirmDelProject = confirm("Project and all the tasks in it will be deleted. Are you sure?")
    var id = this.dataset.id
    if (confirmDelProject === true) {
      $.ajax({
        url: '/projects/' + id,
        type: 'DELETE',
        success: function(result) {
          $("#project-"+ id).remove("#project-"+ id);        
        }
      });
    }  
  });