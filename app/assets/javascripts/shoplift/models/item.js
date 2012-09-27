/*Shoplift.Item = DS.Model.extend({
  id: DS.attr('number'),
  relifts: DS.attr('number'),
  name: DS.attr('string'),
  brand: DS.attr('string'),
  comment: DS.attr('string'),
  url: DS.attr('string'),
  price: DS.attr('number'),
  photo_file_name: DS.attr('string'),
  status: DS.attr("number"),
  views: DS.attr("number"),
  visits: DS.attr("number"),
  hashtags: DS.hasMany("Shoplift.Hashtag", {embedded: true}),
  user: DS.belongsTo("Shoplift.User", {embedded: true})
});*/

Shoplift.ModelPromise = Ember.Mixin.create({
  init: function() {
    this._super();
    this._deferred = $.Deferred();
    this._deferred.promise(this);
    this.one('didLoad', this, '_resolveModelPromise');
    this.one('becameError', this, '_rejectModelPromise');
  },
  _resolveModelPromise: function() {
    console.log("Resolving model promise of " + this.toString());
    this._deferred.resolve(this);
  },
  _rejectModelPromise: function() {
    this._deferred.reject(this);
  }
});

Shoplift.Item = DS.Model.extend({
  name: DS.attr('string'),
  relifts: DS.attr('number'),
  brand: DS.attr('string'),
  comment: DS.attr('string'),
  url: DS.attr('string'),
  price: DS.attr('number'),
  photoFileName: DS.attr('string'),
  user: DS.belongsTo('Shoplift.User'),
  history: DS.belongsTo('Shoplift.History', {embedded: true}),
  hashtagbrands: DS.hasMany('Shoplift.Hashtagbrand', { key: 'hashtagbrand_ids' })
});

