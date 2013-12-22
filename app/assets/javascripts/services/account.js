tcApp.factory( 'Account', function( $resource ) {

	var Account = $resource( "/api/account/", {}, {
		withdraw: {
			method: "POST"
		}
	} )

	return Account

} )
