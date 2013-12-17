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

tcApp.config( function( $routeProvider ) {

	$routeProvider.when( "/", {
		templateUrl: "/templates/home.html",
		controller: "homeCtrl"
	} )

	$routeProvider.when( "/profile/", {
		templateUrl: "/templates/profile.html",
		controller: "profileCtrl"
	} )

	$routeProvider.when( "/account/", {
		templateUrl: "/templates/account.html",
		controller: "accountCtrl"
	} )

	$routeProvider.otherwise( {
		redirectTo: '/'
	} );

} )
