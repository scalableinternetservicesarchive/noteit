var app = angular.module('noteIt', []);

app.controller('MainCtrl', function($scope) {
  $scope.changeVote = function(vote, flag){
    $scope.vote = vote==flag?'None':flag;
    //alert($scope.vote);
  };
});
