// landing-app
//= require "jquery.min"
//= require "jquery_ujs"
//= require "jquery.effects.core"
//= require "jquery.effects.slide"
//= require "jquery.transit"
//= require "bootstrap"
//= require "modernizr-2.6.1.min"
//= require "matchMedia"
//= require "enquire.min"
//= require "okvideo.min"
//= require handlebars-latest
//= require /javascripts/handlebars.runtime
//= require ember-latest
//= require ember-data-latest
//= require_self
//= require landing

Shoplift = {};

Landing = Ember.Application.create({
	rootElement: 'div#landing-container'
});