$(function() {

  // Function to prepend to the beginning of the list
  function addToList(text) {
    var liString = '<li>&#8226; ' + text + '<button class="del_button">X</button></li>';

    $("ul").prepend(liString);
  }

  // On button click prepend text to the list
  $("#add_button").on('click', function() {
    event.preventDefault();
    var newText = $('[name="new_item"]').val();
    addToList(newText);
    $("#inputForm").children("input").val('');
  });

  // Remove li on delete button click
  $("#todo_list").on('click', '.del_button', function() {
    event.preventDefault();
    $(this).parent().remove();
  });

});
