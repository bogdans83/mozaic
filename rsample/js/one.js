define("mod-one", function() {
	return {
		init: function() {
			var one = document.createElement('div');
			one.className = "module-one";
			one.innerHTML = "Module one";
			document.getElementsByTagName('body')[0].appendChild(one);
		},
		unity: function() {
			return 1;
		}
	}
});
