rand = function(upperLimit) {
  return Math.random() * upperLimit;
};

$(document).ready(function() {
  $('#button-1').click(function(){
			 $('#toy-1')
			 .animate({"width" : 200, "height": 200}, "slow")
			 .animate({"left"  : 400, "top"   : 90 }, "fast");
  });
  $('#button-2').click(function(){
			 $('#toy-1')
			 .animate({"width" : 20 , "top"   : 300}, "slow")
			 .animate({"height": 20,  "left"  : 9  }, "fast");
  });
  $('#button-3').click(function(){
			 $('#toy-1').animate({"width" : rand(300),
			 "height": rand(300),
			 "left"  : rand(600),
			 "top"   : rand(300)}, "fast");
			   $('#toy-2').animate({"width" : rand(400) + 100,
						"height": rand(400),
						"left"  : rand(700),
						"top"   : rand(400),
						"opacity" : rand(1.0),
						"borderWidth": rand(20),
						"fontSize" : rand(15) + 5
					       }, "slow");
  });
});