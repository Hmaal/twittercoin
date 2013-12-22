tcApp.directive( 'validateAddress', function() {
	return {
		link: function( $scope, element, attrs, ctrl ) {
			ctrl.$parsers.unshift( function( viewValue ) {
				var address = new SpareCoins.Address( viewValue )

				if ( address.validate() === true ) {
					return ctrl.$setValidity( "notBase58", true )
				} else {
					return ctrl.$setValidity( "notBase58", false )
				}
			} )
		}
	}
} )
