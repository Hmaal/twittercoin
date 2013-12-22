'use strict'

tcApp.controller( "profilesCtrl", function( $scope, $resource, $routeParams, $location ) {

	var Profile = $resource( "/api/profiles/:screenName" )

	$scope.direct = $routeParams.direct

	var profile = Profile.get( {
		screenName: $routeParams.screenName
	}, function( profile ) {
		$scope.profile = profile;
	}, function() {
		$location.path( "/" )
	} )

} )
