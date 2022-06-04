var app = angular.module("Commercial",[]);
app.service("propService",function($http,$q){
	
	var deferred = $q.defer();
	$http.get('resources/json/').then(function(data)
	{
		deferred.resolve(data);
	});
	this.getPlayers = function()
	{
		return deferred.promise;
	}
})
.controller("propCtrl",function($scope,propService)
{
	var promise = propService.getPlayers()
	promise.then(function (data)
			{
		$scope.team=data;
		console.log($scope.team);
			})
})
