'use strict'

tcApp.controller( "profilesCtrl", function( $scope, $resource, $routeParams ) {

	var Profile = $resource( "/api/profiles/:screenName" )

	var profile = Profile.get( {
		screenName: $routeParams.screenName
	}, function( profile ) {
		$scope.profile = profile;
	} )

} )
