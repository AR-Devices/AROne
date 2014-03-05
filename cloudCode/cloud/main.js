// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


// { "maxSpeed" : [“date” : "3/4/13”,  "data" : [ {“user” : “chenchen zheng”, “maxSpeed” : “25.4” }, {obj2} ] ] }
Parse.Cloud.define("scoreBoard", function(request, response) {
	var query = new Parse.Query("Summary");
	//query.equalTo("date", request.params.date);
	//query.equalTo("date", "2014-03-04");
	query.find({
		success: function(user_data_per_day){
			response.success(user_data_per_day.length);
		},
		error: function() {
   		 // error is an instance of Parse.Error.
			response.error("error");
  		}
	});

});
