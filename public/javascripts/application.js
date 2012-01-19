// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function showProgress() {
	$("#progressContainer").html("<div class='progress'></div><div class='loadingText'>Loading...</div>")
}

function endProgress() {
	$("#progressContainer").html("")
}

