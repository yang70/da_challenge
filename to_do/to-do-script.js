$(function() {
  var listCounter = 0;

  // Function to prepend to the beginning of the list
  function addToList(text) {
    $("ul").prepend('<li ' + 'id="item' + listCounter + '">&#8226; ' + text + '</li>');
    listCounter += 1;
  }

  // On button click append text to the list
  $("#add_button").on('click', function() {
    event.preventDefault();
    var newText = $('[name="new_item"]').val();
    addToList(newText);
    $("#inputForm").children("input").val('');
  });

  // Remove li on click
  $('li').on('click', function() {

  });

});
