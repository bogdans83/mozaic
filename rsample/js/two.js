define("mod-two", ["mod-one"], function(one) {
	return {
		init: function() {
			one.init();

			var two = document.createElement('div');
			two.id = "module-two";
			two.innerHTML = "Module two " + (2 * one.unity());

			document.getElementsByTagName('body')[0].appendChild(two);
		}
	}
});
