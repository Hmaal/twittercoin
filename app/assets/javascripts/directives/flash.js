tcApp.directive( "flash", function() {
	return {
		restrict: "E",
		templateUrl: "/templates/_flash_message.html",
		transclude: true
	}
} )
