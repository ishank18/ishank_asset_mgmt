// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function showProgress() {
	$("#progressContainer").html("<div class='progress'></div><div class='loadingText'>Loading...</div>")
}

function endProgress() {
	$("#progressContainer").html("")
}

function addTags() {
	var tagsArray = $("#asset_tags_field").attr("value").split(",");
	$("#asset_tags_field").attr("value", "") 
	var tagsHTML = ""
	var previousTags = $(".DelTag").get()
	$.each(previousTags, function(key, currEle) { 
 		tagsHTML += "<span onclick='delTag(this)' class='DelTag'>"+currEle.innerHTML+"</span>";
	});
	$.each(tagsArray, function(key, value) { 
		if(value.trim() != "") {
 			tagsHTML += "<span onclick='delTag(this)' class='DelTag'>"+value+"</span>";
 		}
	});
	$("#tags").html(tagsHTML)
}
	
function fillTagContent() {
	addTags()
	var previousTags = $(".DelTag").get()
	var tags = ""
	$.each(previousTags, function(key, currEle) {
		if(key != previousTags.length-1) { 
	 		tags += currEle.innerHTML+",";
	 	}
	 	else {
	 		tags += currEle.innerHTML
	 	}
	});
	$("#asset_tags_field").attr("value", tags)
}

function delTag(currentTag) {
	 $(currentTag).remove();
}

function disableTo(currEle) {
	var returned = $("#assignment_date_returned");
	if(currEle.value == "false") {
		returned.attr("disabled", false);
		returned.datepicker({"disabled": false, dateFormat: "dd/mm/yy" });
	}
	else {
		returned.attr("disabled", true);
		returned.attr("value", "");
		returned.datepicker({"disabled":true});
	}	
}

(function($){
	$.fn.jTruncate = function(options) {
	   
		var defaults = {
			length: 300,
			minTrail: 20,
			moreText: "more",
			lessText: "less",
			ellipsisText: "...",
			moreAni: "",
			lessAni: ""
		};
		
		var options = $.extend(defaults, options);
	   
		return this.each(function() {
			obj = $(this);
			var body = obj.html();
			
			if(body.length > options.length + options.minTrail) {
				var splitLocation = body.indexOf(' ', options.length);
				if(splitLocation != -1) {
					// truncate tip
					var splitLocation = body.indexOf(' ', options.length);
					var str1 = body.substring(0, splitLocation);
					var str2 = body.substring(splitLocation, body.length - 1);
					obj.html(str1 + '<span class="truncate_ellipsis">' + options.ellipsisText + 
						'</span>' + '<span class="truncate_more">' + str2 + '</span>');
					obj.find('.truncate_more').css("display", "none");
					
					// insert more link
					obj.append(
						'<div class="clearboth">' +
							'<a href="#" class="truncate_more_link">' + options.moreText + '</a>' +
						'</div>'
					);

					// set onclick event for more/less link
					var moreLink = $('.truncate_more_link', obj);
					var moreContent = $('.truncate_more', obj);
					var ellipsis = $('.truncate_ellipsis', obj);
					moreLink.click(function() {
						if(moreLink.text() == options.moreText) {
							moreContent.show(options.moreAni);
							moreLink.text(options.lessText);
							ellipsis.css("display", "none");
						} else {
							moreContent.hide(options.lessAni);
							moreLink.text(options.moreText);
							ellipsis.css("display", "inline");
						}
						return false;
				  	});
				}
			} // end if
			
		});
	};
})(jQuery);
