var app = angular.module('common', []);

app.controller('MyCtrl1', ['$scope', 'UserFactory', function ($scope, UserFactory) {
    UserFactory.get({}, function (userFactory) {
        $scope.fieldName = userFactory.fieldName;
        $scope.fieldValue = userFactory.fieldValue;
    })
}]);