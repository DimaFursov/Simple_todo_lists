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
  $(document).on('click', '.delete_project', function() {//Нужна инициализация клика для новосозданного проекта, убрать удаляет проект после обновленмя страницы
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
    $("#project_name_" + dataset_id).toggle();
  });
  $(document).on('click', '.update_project', function() {
    var dataset_id = this.dataset.id;
    var new_project_name = $(".project_edit_"+dataset_id).val()
    $.ajax({
      url: '/projects/' + dataset_id,
      type: 'PATCH',
      data: {project: {name: new_project_name}},
      success: function(update_data) {
        $("#project_name_" + dataset_id).text(update_data.name);
        $("#project_input_" + dataset_id).toggle();
        $("#project_name_" + dataset_id).toggle();
      }      
    });
  });  
});  
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
  */
