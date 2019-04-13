$(document).ready(function () {
  const clickMe = document.querySelector(".jq");
  clickMe.addEventListener("click", makeRequest);
});



function makeRequest() {
  var select_val = $("#products").val();
  var cont = document.querySelector(".cont");
  var newElem = document.createElement('div');
    newElem.className = 'my_div';
  $.ajax({
    url: "/htts",
    //type: 'post',
    dataType: 'json',
    data: 'temp=' + select_val,
    beforeSend: function(xhr, opts){
      cont.appendChild(newElem).innerHTML = 'Please wait.... надо сделать нормальнае отображение почему то не отрисовываются другие блоки КОЛ бутрстапа, удаление ненужного контента со страницы, как-то всё оптимизировать индексы добавить!'
    },

    success: function(jsondata) {

      console.log(select_val);
      var remove = document.querySelector(".my_div");
      if (remove != null) remove.parentNode.removeChild(remove);

      var col3 = document.createElement('div');
        col3.className = 'my_div col-3';
      var col7 = document.createElement('div');
        col7.className = 'my_div col-md-7';
      var col2 = document.createElement('div');
        col2.className = 'my_div col-2';


      cont.appendChild(newElem)
      jsondata.forEach(function(item, i, jsondata) {
        cont.appendChild(col3).append(item.product_name);
        cont.appendChild(col7).append(item.description);
        cont.appendChild(col2).append(item.price_min + ' - ' + item.price_max);
      });
    }
  });
}
