$( document ).ready(function() {
  // console.log( "ready!" );
  $.getJSON("api/config/shortname", function (json) {
  var l = document.querySelectorAll('[id^="shortname-"]')
    $.each(l, function (index, value) {
      var span = document.getElementById(value.id);
      span.textContent = json.text;
      var text = span.textContent;
    });
  });

  $.getJSON("api/config/fullname", function (json) {
  var l = document.querySelectorAll('[id^="fullname-"]')
    $.each(l, function (index, value) {
      var span = document.getElementById(value.id);
      span.textContent = json.text;
      var text = span.textContent;
    });
  });

  $.getJSON("api/config/phone", function (json) {
  var l = document.querySelectorAll('[id^="phone-"]')
    $.each(l, function (index, value) {
      var span = document.getElementById(value.id);
      span.textContent = json.text;
      var text = span.textContent;
    });
  });

  $.getJSON("api/config/email", function (json) {
  var l = document.querySelectorAll('[id^="email-"]')
    $.each(l, function (index, value) {
      var span = document.getElementById(value.id);
      span.textContent = json.text;
      var text = span.textContent;
    });
  });

  $.getJSON("api/config/address", function (json) {
  var l = document.querySelectorAll('[id^="address-"]')
    $.each(l, function (index, value) {
      var span = document.getElementById(value.id);
      span.textContent = json.text;
      var text = span.textContent;
    });
  });

  $.getJSON("api/config/detail", function (json) {
  var l = document.querySelectorAll('[id^="detail-"]')
    $.each(l, function (index, value) {
      var span = document.getElementById(value.id);
      span.textContent = json.text;
      var text = span.textContent;
    });
  });
});
