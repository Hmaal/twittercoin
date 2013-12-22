'use strict'

tcApp.controller( "accountCtrl", function( $scope, $resource, Account, $location ) {

	Account.get( "/", function( account ) {
		$scope.account = account

		$scope.submitWithdraw = function() {
			if ( $scope.withdrawForm.$invalid ) {
				return;
			}

			account.$withdraw( {
				to_address: $scope.withdraw.toAddress,
				amount: $scope.withdraw.amount,
			}, function( response ) {
				$scope.account = response
			}, function( error ) {
				$scope.account = response
			} )
		}
	}, function( error ) {
		$location.path( "/" )
	} )
} )
