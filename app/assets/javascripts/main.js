$(document).ready(function () {
  $('.js-example-basic-single').select2();
  $('#btn_check').click(function () {
    let select_category = $("#products").val();
    $.ajax({
      url: "check",
      dataType: 'json',
      data: 'select_category=' + select_category,
      beforeSend: function(xhr, opts){
        $('#btn_check').prop('disabled', true);
        $('#btn_CSV').hide();
        $("div.remove").remove();
        $(".cont").append("<div class='remove'>Пожалуйста подождите это может занять какое-то время :3 индексы добавить!</div>")
      },
      success: function(jsondata) {
        $('#btn_check').prop('disabled', false);
        $('#btn_CSV').show();
        $('#btn_update').show();
        $("div.remove").remove();
        console.log(select_category);
        let data = "<div class='remove col-3'><b>Name</b></div><div class='remove col-md-7'><b>Description</b></div><div class='remove col-2'><b>Price</b></div>";
        jsondata.forEach(function(item, i, jsondata) {
          data += "<div class='remove col-3'>" + item.product_name + "</div><div class='remove col-md-7'>" + item.description + "</div><div class='remove col-2'>" + item.price_min + ' - ' + item.price_max + "</div>"
        });
        $(".cont").append(data);
      }
    });
  });

  $('#btn_update').click(function () {
    let select_category = $("#products").val();
    $.ajax({
      url: "updateProduct",
      dataType: 'json',
      data: 'select_category=' + select_category,
      beforeSend: function(xhr, opts){
        $('#btn_check').prop('disabled', true);
        $('#btn_update').prop('disabled', true);
        $('#btn_CSV').hide();
        $("div.remove").remove();
        $(".cont").append("<div class='remove'>Пожалуйста подождите :3 </div>")
      },
      success: function(jsondata) {
        $('#btn_check').prop('disabled', false);
        $('#btn_update').prop('disabled', false);
        $('#btn_CSV').show();
        $("div.remove").remove();
        console.log(select_category);
        let data = "<div class='remove col-3'><b>Name</b></div><div class='remove col-md-7'><b>Description</b></div><div class='remove col-2'><b>Price</b></div>";
        jsondata.forEach(function(item, i, jsondata) {
          data += "<div class='remove col-3'>" + item.product_name + "</div><div class='remove col-md-7'>" + item.description + "</div><div class='remove col-2'>" + item.price_min + ' - ' + item.price_max + "</div>"
        });
        $(".cont").append(data);
      }
    });
  });

});
