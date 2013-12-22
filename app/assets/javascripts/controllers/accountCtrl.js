'use strict'

tcApp.controller( "accountCtrl", function( $scope, $resource, Account, $location ) {
	$scope.shown = false
	Account.get( "/", function( account ) {
		$scope.account = account
		$scope.shown = true
		$scope.submitWithdraw = function() {
			if ( $scope.withdrawForm.$invalid ) {
				return;
			}

			account.$withdraw( {
				toAddress: $scope.withdraw.toAddress,
				withdrawAmount: $scope.withdraw.amount,
			}, function( response ) {
				$scope.account = response
			}, function( error ) {
				console.log( error )
				$scope.errorMessages = error
			} )
		}
	}, function( error ) {
		$location.path( "/" )
	} )
} )
