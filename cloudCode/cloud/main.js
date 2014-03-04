
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

Parse.Cloud.define("scoreBoard", function(request, response) {
	var query = new Parse.Query("Summary");
	query.equalTo("date", request.params.date);
	query.find({
		success:function(results) {
			
		}
	})
}
