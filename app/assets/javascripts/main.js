$(document).ready(function () {
  $('.js-example-basic-single').select2();
  $('#btn_check').click(function () {
    query("check")
  });
  $('#btn_update').click(function () {
    query("updateProduct")
  });
});

function query(url) {
  let select_category = $("#categories").val();
  $.ajax({
    url: url,
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
      $('#btn_update').show();
      $('#btn_CSV').show();
      $("div.remove").remove();
      console.log(select_category);
      let data = "<div class='col-12 mx-auto remove'><i>Полную информацию о товарах можно получить из загружаемого CSV фала</i></div><div class='remove col-3'><b>Name</b></div><div class='remove col-md-7'><b>Description</b></div><div class='remove col-2'><b>Price</b></div>";
      jsondata.forEach(function(item, i, jsondata) {
        data += "<div class='remove col-3'>" + item.product_name + "</div><div class='remove col-md-7'>" + item.description + "</div><div class='remove col-2'>" + item.price_min + ' - ' + item.price_max + "</div>"
      });
      $(".cont").append(data);
    }
  });
}
