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
<<<<<<< HEAD

=======
>>>>>>> c8011eacc5263c8001e2ec48c16ae6984e10c607
//= require dropzone
//= require_tree .

$(function(){
	//ロゴ 設定
	$("#logo a img").hover(
		function(){
			$(this).fadeTo(100,0.6);
		},
		function(){
			$(this).fadeTo(100,1);
		}
	);

	$("#t_title").fadeTo(500,1);
	$("#t_take").delay(1500).fadeTo(1000,1);
	$("#t_upload").delay(2500).fadeTo(1000,1);
	$("#t_finishing").delay(3500).fadeTo(1000,1);
	$("#t_winner").delay(4500).fadeTo(1000,1);
	$("#t_lose").delay(5500).fadeTo(1000,1);

	$("#uploadSubmit,#back a").hover(
		function(){
			$(this).fadeTo(100,0.6);
		},
		function(){
			$(this).fadeTo(100,1);
		}
	);

<<<<<<< HEAD
	/*
	$("#tutorialArea img").hide();
	$("#tutorialArea img").fadeTo(2000,1);

	$("#logo a").click(function(){
		$("#tutorialArea img").fadeIn(2000);
	});
	*/
=======
	$("#spTutorialArea img").hide();
	$("#spTutorialArea img").fadeTo(1000,1);
>>>>>>> c8011eacc5263c8001e2ec48c16ae6984e10c607
});
