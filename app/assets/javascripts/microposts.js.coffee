updateCountdown = ->
  # 140 is the max message length
  length = $("#micropost_content").val().length
  remaining = 140 - length

  $countdown = $(".countdown")
  $countdown.text remaining + " characters remaining"
  $countdown.css "color", (if (140 >= remaining >= 21) then "gray")
  $countdown.css "color", (if (21 > remaining >= 11) then "black")
  $countdown.css "color", (if (11 > remaining)  then "red")

###updateColor = ->
  length = $("#micropost_content").val().length
  micropost = $("#micropost_content").val()
  beginSpan = '<span class="split_part">'
  endSpan = '</span>'
  if length > 128 
    micropost += micropost.substring(0,128) + beginSpan + micropost.substring(128, length) + endSpan
    $("#split_part").css "background-color", ("pink")
  else
    $("#micropost_content").css "background-color", ("white")
  $("#micropost_content").val(micropost)###

$ ->
  updateCountdown()
  $("#micropost_content").on 'keyup keydown change', updateCountdown
  # $("#micropost_content").on 'keyup change', updateColor