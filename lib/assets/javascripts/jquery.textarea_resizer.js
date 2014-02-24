/*
jquery.textarea_resizer.js v0.0.1 - Copyright 2013, i2bskn
*/
(function($){
  $.fn.textareaResizer = function(params){
    var defaults = {
      init_size: 10,
      resizable: false
    };

    var settings = $.extend(defaults, params);
    var init_size = $(this).attr("rows") || settings.init_size;

    var numOfRow = function(textarea){
      return $(textarea).val().split("\n").length;
    };

    var resize = function(){
      var i = numOfRow(this);
      if (i > init_size){
        $(this).attr("rows", i);
      }
    };

    if (!$(this).attr("rows")) {
      $(this).attr("rows", init_size);
    };

    if (settings.resizable === false){
      $(this).css("overflow", "hidden");
      $(this).css("resize", "none");
    };

    $(this).on("keyup", resize);

    return this;
  };
})(jQuery);