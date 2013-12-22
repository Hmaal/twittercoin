var tcApp = angular.module( 'tcApp', [
	'ngRoute',
	'ngResource',
	'ui.bootstrap'
] )

tcApp.config( function( $httpProvider ) {
	var authToken;
	authToken = $( "meta[name=\"csrf-token\"]" ).attr( "content" );
	return $httpProvider.defaults.headers.common[ "X-CSRF-TOKEN" ] = authToken;
} );

tcApp.run( function( $rootScope, $location ) {
	$rootScope.global = {
		signedIn: signedIn,
		isActive: function( path ) {
			return path === $location.path()
		}
	}
} )

tcApp.config( function( $routeProvider ) {

	$routeProvider.when( "/", {
		templateUrl: "/templates/home.html",
		controller: "homeCtrl"
	} )

	$routeProvider.when( "/how-it-works/", {
		templateUrl: "/templates/how-it-works.html"
	} )

	$routeProvider.when( "/profile/:screenName", {
		templateUrl: "/templates/profile.html",
		controller: "profilesCtrl"
	} )

	$routeProvider.when( "/profile/", {
		templateUrl: "/templates/profile.html",
		controller: "profilesCtrl"
	} )

	$routeProvider.when( "/account/", {
		templateUrl: "/templates/account.html",
		controller: "accountCtrl"
	} )

	$routeProvider.otherwise( {
		redirectTo: '/'
	} );

} )
