$(document).ready(function() {
	$("#calculate-button").click(function() {
		$("#result").html("");

		var amount = $("#amount").val();
		if (!isNumeric(amount)) {
			$("#result").text("Not valid amount");
		}

		var goal_curr = $("#goal_currency").val();

      	$.post("/api/rates/exchange",
      	{
      		"amount": amount,
      		"origin_currency": $("#origin_currency").val(),
      		"goal_currency": goal_curr
      	}, function(res) {
      		$("#result").html(`${goal_curr} $${res.result}`);
        });
    });
});

function validateNumericInput(input) {
	// Remove non-numeric characters, except for dots (.) to allow floats
	input.value = input.value.replace(/[^0-9.]/g, '');

	// Ensure there's only one dot (.) in the input
	if (input.value.split('.').length > 2) {
		input.value = input.value.substring(0, input.value.lastIndexOf('.'));
	}
}

function isNumeric(input) {
	// Use a regular expression to check for a valid numeric input (integer or float)
	// This regex allows for integers or floats, including both dot (.) and comma (,) as decimal separators
	var numericRegex = /^-?\d*\.?\d+$/;
	return numericRegex.test(input);
}