var app = angular.module('noteIt', []);

app.controller('MainCtrl', function($scope) {
  $scope.changeVote = function(vote, flag, num){
    $scope.vote = vote==num?0:num;
    //alert($scope.vote);
  };
});
