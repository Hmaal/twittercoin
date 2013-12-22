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

tcApp.run( function( $rootScope ) {
	$rootScope.global = {
		signedIn: signedIn
	}
} )

tcApp.config( function( $routeProvider ) {

	$routeProvider.when( "/", {
		templateUrl: "/templates/home.html",
		controller: "homeCtrl"
	} )

	$routeProvider.when( "/how-it-work/", {
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

// Instantiate Pusher
// var pusher = new Pusher( 'af66c456e5950e60e048' );

// Pusher Debugger
// Pusher.log = function( message ) {
// 	window.console.log( message );
// };

// var channel = pusher.subscribe( 'test_channel' );
// channel.bind( 'my_event', function( data ) {
// 	alert( data.message );
// } );
