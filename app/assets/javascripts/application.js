// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.table_sort.min
//= require jquery.textarea_resizer
//= require_tree .
//= require bootstrap.min

$(function(){
  $("textarea.resize").textareaResizer({
    init_size: 10,
    resizable: false
  });

  $("#execute_user_search").on("click", function(){
      $.ajax({
        url: "/users/search.json",
        data: {
          keyword: $("#user_keyword").val()
        },
        dataType: "json",
      }).done(function(data){
        $("#search_user_list").empty();
        $.each(data, function(){
          var $jqtr = $("<tr>");
          $jqtr.append($("<td>", {text: this.name}));
          $jqtr.append($("<td>", {text: this.email}));
          $jqtr.append($("<td>", {align: "right"}).append($("<a>", {class: "btn btn-inverse btn-xs set_user", text: "設定"})));
          $("#search_user_list").append($jqtr);
        });
      }).fail(function(){
        alert("検索に失敗しました");
      });

      return false;
    });

    $(document).on("click", "#search_user_list a.set_user", function(){
      var email = $(this).closest("td").prev("td").text();
      $("input#email").val(email);
      $("#user_keyword").val("");
      $("#search_user_list").empty();
      $("div#user_search_modal").modal("hide");
      return false;
    });
});
