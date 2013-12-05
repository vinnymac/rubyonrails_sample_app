updateCountdown = ->
  # 140 is the max message length

  length = $("#micropost_content").val().length

  remaining = 140 - length

  #micropost = $("#micropost_content").text()
  #beginSpan = '<span class="split_part">'
  #endSpan = '</span>'
  #if length > 128 
  #  micropost.substring(0,128) + beginSpan + micropost.substring(128, length) + endSpan
  #  $("#split_part").css "background-color", ("pink")
  #else
  #  $("#micropost_content").css "background-color", ("white")
  #  micropost + ''
  #$("#micropost_content").val("")

  $(".countdown").text remaining + " characters remaining"
  $(".countdown").css "color", (if (140 >= remaining >= 21) then "gray")
  $(".countdown").css "color", (if (21 > remaining >= 11) then "black")
  $(".countdown").css "color", (if (11 > remaining)  then "red")

$ ->
  updateCountdown()
  $("#micropost_content").on 'keyup change', updateCountdown

