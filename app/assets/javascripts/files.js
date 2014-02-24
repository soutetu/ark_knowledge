(function(){
  $(function(){
    $("table#files").tableSort({
      indexes: [0, 1, 2, 3, 4],
      compare: function(a, b){
        a = a.replace(" bytes", "") * 1;
        b = b.replace(" bytes", "") * 1;
        return a - b;
      },
    });
  });
})();