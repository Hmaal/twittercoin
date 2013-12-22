'use strict'

tcApp.controller( "profilesCtrl", function( $scope, $resource, $routeParams, $location ) {
	$scope.shown = false

	var Profile = $resource( "/api/profiles/:screenName" )
	$scope.direct = $routeParams.direct

	var profile = Profile.get( {
		screenName: $routeParams.screenName
	}, function( profile ) {
		$scope.profile = profile;
		$scope.shown = true
	}, function( error ) {
		$location.path( "/" )
	} )

} )
