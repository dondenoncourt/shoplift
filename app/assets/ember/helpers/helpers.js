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

Handlebars.registerHelper('identify', function(options) {
	var id = this.get("id"),
			name = options.hash['name'],
			isLink = options.hash['href'],
			attr = 'id=';
	
	if(isLink) attr = 'href=#';
	
	return attr + name + id + '';
});