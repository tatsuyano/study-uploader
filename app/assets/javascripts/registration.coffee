$('.registrations.new').ready ->
  if $("#user_email").val() == ''
    $("#user_email").focus();

  if $("#user_username").val() == ''
    $("#user_username").focus();
