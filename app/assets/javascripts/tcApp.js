var tcApp = angular.module( 'tcApp', [
	'ngRoute',
	'ngResource'
] )

tcApp.config( function( $httpProvider ) {
	var authToken;
	authToken = $( "meta[name=\"csrf-token\"]" ).attr( "content" );
	return $httpProvider.defaults.headers.common[ "X-CSRF-TOKEN" ] = authToken;
} );

tcApp.config( function( $routeProvider ) {

	$routeProvider.when( "/", {
		templateUrl: "/templates/index.html",
		controller: "indexCtrl"
	} )

	$routeProvider.when( "/profile/", {
		templateUrl: "/templates/profile.html",
		controller: "profileCtrl"
	} )

	$routeProvider.when( "/account/", {
		templateUrl: "/templates/profile.html",
		controller: "accountCtrl"
	} )

	$routeProvider.otherwise( {
		redirectTo: '/'
	} );

} )
