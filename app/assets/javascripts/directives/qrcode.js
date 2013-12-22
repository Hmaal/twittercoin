tcApp.directive( 'qrcode', function( $timeout ) {
	return {
		link: function( $scope, element, attrs, ctrl ) {
			$scope.$watch( "account", function() {
				if ( !$scope.account ) {
					return;
				}
				var address = $scope.account.address
				new QRCode( document.getElementById( "qrcode" ), address );
			} )
		}
	}
} )
