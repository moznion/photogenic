// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require dropzone
//= require_tree .

$(function(){
	//dropzone 設定
	$("#logo a img").hover(
		function(){
			$(this).fadeTo(100,0.6);
		},
		function(){
			$(this).fadeTo(100,1);
		}
	);
	/* $(".new_content").addClass("dropzone-custom"); */

	$("#tutorialArea img").fadeIn(2000);
	//ドロップゾーン　ここから

	//ドロップゾーン　ここまで

	/*
$(".dropzone-custom").hover(
		function(){
			$(this).css({"background":"#dcdcdc"},200);
	},
		function(){
			$(this).css({"background":"#FFFFFF"},200);
		}
	);
*/
});