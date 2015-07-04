$(function() {
  // Function to prepend to the beginning of the list
  function addToList(text) {
    $("ul").prepend("<li>&#8226; " + text + "</li>")
  }

  // On button click append text to the list
  $("#add_button").on('click', function() {
    event.preventDefault();
    var newText = $('[name="new_item"]').val();
    addToList(newText);
  });

});
