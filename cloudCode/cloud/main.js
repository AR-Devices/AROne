require('cloud/installation.js');

// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


// { "maxSpeed" : [“date” : "3/4/13”,  "data" : [ {“user” : “chenchen zheng”, “maxSpeed” : “25.4” }, {obj2} ] ] }
Parse.Cloud.define("scoreBoard", function(request, response) {
	var query = new Parse.Query("Summary");
	query.include("player");
	//query.equalTo("displayName", "danny");
//	query.equalTo("date", request.params.date);
	query.addDescending(request.params.datatype);
//	query.select("displayName", request.params.datatype);
	query.greaterThanOrEqualTo("date", request.params.startDate);
	query.lessThanOrEqualTo("date", request.params.endtDate);
	query.find({
		success: function(result){
			response.success(result);
		},
		error: function() {
   		 // error is an instance of Parse.Error.
			response.error("error");
  		}
	});

});
