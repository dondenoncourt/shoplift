// This file contains utilities for creating bound helpers

// For reference: https://github.com/wagenet/ember.js/blob/ac66dcb8a1cbe91d736074441f853e0da474ee6e/packages/ember-handlebars/lib/views/bound_property_view.js
Ember.Handlebars.BoundHelperView = Ember.View.extend(Ember._Metamorph, {

	context: null,
	options: null,
	property: null,
	// paths of the property that are also observed
	propertyPaths: [],

	value: Ember.K,

	valueForRender: function() {
		var value = this.value(Ember.Handlebars.getPath(this.context, this.property, this.options), this.options.hash);
		if (this.options.hash.escaped) { value = Handlebars.Utils.escapeExpression(value); }
		return value;
	},

	render: function(buffer) {
		buffer.push(this.valueForRender());
	},

	valueDidChange: function() {
		if (this.morph.isRemoved()) { return; }
		this.morph.html(this.valueForRender());
	},

	didInsertElement: function() {
		this.valueDidChange();
	},

	init: function() {
		this._super();
		Ember.addObserver(this.context, this.property, this, 'valueDidChange');
		this.get('propertyPaths').forEach(function(propName) {
				Ember.addObserver(this.context, this.property + '.' + propName, this, 'valueDidChange');
		}, this);
	},

	destroy: function() {
		Ember.removeObserver(this.context, this.property, this, 'valueDidChange');
		this.get('propertyPaths').forEach(function(propName) {
				this.context.removeObserver(this.property + '.' + propName, this, 'valueDidChange');
		}, this);
		this._super();
	}

});

Ember.Handlebars.registerBoundHelper = function(name, func) {
	var propertyPaths = Array.prototype.slice.call(arguments, 2);
	Ember.Handlebars.registerHelper(name, function(property, options) {
		var data = options.data,
				view = data.view,
				ctx  = this;

		var bindView = view.createChildView(Ember.Handlebars.BoundHelperView, {
			property: property,
			propertyPaths: propertyPaths,
			context: ctx,
			options: options,
			value: func
		});

		view.appendChild(bindView);
	});
};

Handlebars.registerHelper('even', function(index, options) {
	console.dir(index);
	if(index%2 == 0)
		return options.fn(this);
	else
		return options.inverse(this);
});

Ember.Handlebars.registerBoundHelper('pluralize', function(number, options) {
	var single = options['single'],
			plural = options['plural'];
			
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


Ember.Handlebars.registerBoundHelper('truncate', function(context, options) { //str, length, omission) {
	var length = options['length'],
			append = options['append'],
			str = context; //this.get(context);
			
	if (str != null && str != "null" && str.length > length) {
		return str.substring(0, length - append.length) + append;
	} else if (str != null) {
		return str;
	} else {
		return "";
	}
});

Ember.Handlebars.registerBoundHelper('currency', function(value, options) {
	if(!value) return "";
	value = Math.round(value);
	return "$ " + value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
});