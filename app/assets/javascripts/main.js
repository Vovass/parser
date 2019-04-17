$(document).ready(function () {
  $('.js-example-basic-single').select2();
  $('#btn_check').click(function () {
    var select_category = $("#products").val();
    $.ajax({
      url: "hts",
      dataType: 'json',
      data: 'select_category=' + select_category,
      beforeSend: function(xhr, opts){
        $("div.remove").remove();
        $(".cont").append("<div class='remove'>Пожалуйста подождите это может занять какое-то время :3 индексы добавить!</div>")
      },
      success: function(jsondata) {
        $("div.remove").remove();
        console.log(select_category);
        let data = "<br><div class='remove col-3'>Name</div><div class='remove col-md-7'>Description</div><div class='remove col-2'>Price</div>";
        jsondata.forEach(function(item, i, jsondata) {
          data += "<div class='remove col-3'>" + item.product_name + "</div><div class='remove col-md-7'>" + item.description + "</div><div class='remove col-2'>" + item.price_min + ' - ' + item.price_max + "</div>"
        });
        $(".cont").append(data);
      }
    });
  });
});
