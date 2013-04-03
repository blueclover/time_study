jQuery ->
	$('#response_q2selection').parent().parent().hide()
	$('#response_q1text').parent().parent().hide()
	$('#response_q2text').parent().parent().hide()
	$('#response_q3text').parent().parent().hide()
	q2options = $('#response_q2selection').html()
	$('#response_q1selection').change ->
		q1selection = $('#response_q1selection :selected').text()
		escaped_selection = q1selection.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
		options = $(q2options).filter("optgroup[label='#{escaped_selection}']").html()
		if options
      $('#response_q2selection').html(options)
      $('#response_q2selection').parent().parent().show()
    else
      $('#response_q2selection').empty()
      $('#response_q2selection').parent().parent().hide()
    if q1selection == "Other"
      $('#response_q1text').parent().parent().show()
      $('#response_q2text').parent().parent().show()
    else
      $('#response_q1text').val("")
      $('#response_q1text').parent().parent().hide()
      $('#response_q2text').val("")
      $('#response_q2text').parent().parent().hide()

