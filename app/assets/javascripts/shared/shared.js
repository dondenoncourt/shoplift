// This file performs all the includes of Ember classes (models, view, controllers)
// between all the Shoplift Ember apps (Landing, Shoplift, etc)
// Note that we should probably just use the Shoplift namespace for all
// of the classes shared between the various ember apps, since Shoplift
// is the most generic name. e.g. both the Shoplift and Landing apps
// will use Shoplift.User
//= require_self
//= require_tree ./models
//= require ./adapter
//= require ./store

// Declare namespace for all the shared classes (models, views, controllers, etc).
// This allows for easier debugging in some cases.
// NOTE: only have to do this for non-Shoplift Ember apps (e.g. Landing)
window.Shoplift = window.Shoplift || Ember.Namespace.create();
