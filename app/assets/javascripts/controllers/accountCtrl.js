'use strict'

tcApp.controller( "accountCtrl", function( $scope, $resource, Account ) {

	Account.get( "/", function( account ) {
		$scope.account = account

		$scope.submitWithdraw = function() {
			if ( $scope.withdrawForm.$invalid ) {
				console.log( "Invalid!" )
				return;
			}

			account.$withdraw( {
				to_address: $scope.withdraw.toAddress,
				amount: $scope.withdraw.amount,
			}, function( response ) {
				$scope.account.balance = response.balance
				$scope.account.messages.withdraw = response.messages.withdraw
			}, function( error ) {
				console.log( "error", error )
				$scope.account.messages.withdraw = error.messages.withdraw
			} )
		}
	} )
} )
