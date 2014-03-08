// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


// { "maxSpeed" : [“date” : "3/4/13”,  "data" : [ {“user” : “chenchen zheng”, “maxSpeed” : “25.4” }, {obj2} ] ] }
Parse.Cloud.define("scoreBoard", function(request, response) {
	var query = new Parse.Query("Summary");
	//query.equalTo("displayName", "danny");
	query.equalTo("date", "2014-03-05");
	query.addAscending("maxSpeed");
	query.select("maxSpeed");
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
