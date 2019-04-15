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
        $(".cont").append("<div class='remove'>Please wait.... надо сделать нормальнае отображение почему то не отрисовываются другие блоки КОЛ бутрстапа, удаление ненужного контента со страницы, как-то всё оптимизировать индексы добавить!</div>")
      },
      success: function(jsondata) {
        console.log(select_category);
        let data = "";
        jsondata.forEach(function(item, i, jsondata) {
          data += "<div class='remove col-3'>" + item.product_name + "</div><div class='remove col-md-7'>" + item.description + "</div><div class='remove col-2'>" + item.price_min + ' - ' + item.price_max + "</div>"
        });
        $(".cont").append(data);
      }
    });
  });


});
