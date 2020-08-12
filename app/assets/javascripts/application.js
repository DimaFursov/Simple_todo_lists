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
  $("p").hover(function(){
      $(this).css("background-color", "yellow");
  }, function(){
      $(this).css("background-color", "pink");
  });
  $(".new_project").show("slow");/*remove afterfinish work*/
  $('.delete_project').click(function() {//Нужна инициализация клика для новосозданного проекта, убрать удаляет проект после обновленмя страницы
    var id = this.dataset.id
    $.ajax({
      url: '/projects/' + id,
      type: 'DELETE',
      success: function(result) {
        alert("success application.js"+"#project-"+ id); 
        $("#project-"+ id).remove("#project-"+ id);        
      }      
    });
  });
/*$("#delete_button_186").html("text")*/
  $("body").on("click", ".remove-button", function () {
        $(this).parent().remove();
      });

  $("body").on("click", ".create-button", function () {
        var countPlayers = $('.example li').length;/*количество в списке*/
        var player = '<li>Игрок ' + (countPlayers+1)  + 
        ' <a href="javascript: return false;" class="remove-button right">Удалить</a></li>';
        $('.example').append(player); 
      });
/*для динамических элементов используется делегированная обработка событий.
обработчики «навешиваются» не на отсутствующие 
в dom элементы, а на существующий родительский объект. body
будет вызван данный обработчик для всех элементов,
 соответствующих селектору, даже если этих элементов не было во время объявлении обработчика (например при загрузке страницы).
*/





});
