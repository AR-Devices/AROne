// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


// { "maxSpeed" : [“date” : "3/4/13”,  "data" : [ {“user” : “chenchen zheng”, “maxSpeed” : “25.4” }, {obj2} ] ] }
Parse.Cloud.define("scoreBoard", function(request, response) {
	var query = new Parse.Query("Summary");
	query.equalTo("date", request.params.date);
	var results = {
	var txt = '{ "employees" : [' +
'{ "firstName":"John" , "lastName":"Doe" },' +
'{ "firstName":"Anna" , "lastName":"Smith" },' +
'{ "firstName":"Peter" , "lastName":"Jones" } ]}';
	response.success(txt);
}
