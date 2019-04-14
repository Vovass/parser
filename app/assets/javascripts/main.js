$(document).ready(function () {
  const clickMe = document.querySelector(".jq");
  clickMe.addEventListener("click", makeRequest);
});
function makeRequest() {
  var select_category = $("#products").val();
  $.ajax({
    url: "/htts",
    //type: 'post',
    dataType: 'json',
    data: 'select_category=' + select_category,
    beforeSend: function(xhr, opts){
      $("div.remove").remove();
      $(".cont").append("<div class='remove'>Please wait.... надо сделать нормальнае отображение почему то не отрисовываются другие блоки КОЛ бутрстапа, удаление ненужного контента со страницы, как-то всё оптимизировать индексы добавить!</div>")
    },
    success: function(jsondata) {
      console.log(select_category);

      jsondata.forEach(function(item, i, jsondata) {
        $(".cont").append("<div class='remove col-3'>" + item.product_name + "</div>")//.append(item.product_name);
        $(".cont").append("<div class='remove col-md-7'>" + item.description + "</div>")//.append(item.description);
        $(".cont").append("<div class='remove col-2'>" + item.price_min + ' - ' + item.price_max + "</div>")//.append(item.price_min + ' - ' + item.price_max);
      });
    }
  });
}
