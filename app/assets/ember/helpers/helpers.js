Handlebars.registerHelper('even', function(index, options) {
	console.dir(index);
	if(index%2 == 0)
		return options.fn(this);
	else
		return options.inverse(this);
});

Handlebars.registerHelper('pluralize', function(number, single, plural) {
  if (number === 1) { return single; }
  else { return plural; }
});