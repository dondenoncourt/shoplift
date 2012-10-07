Shoplift.User = DS.Model.extend({
  email: DS.attr('string'),
  sngupState: DS.attr('string'),
  password: DS.attr('string'),
  passwordConfirm: DS.attr('string'),
  vanityUrl: DS.attr('string'),
  fullName: DS.attr('string'),
  description: DS.attr('string'),
  avatar: DS.attr('string'),
  url: DS.attr('string'),
  followeeCount: DS.attr('number'),
  followerCount: DS.attr('number'),
  items: DS.hasMany('Shoplift.Item'),
  followees: DS.hasMany('Shoplift.User'),
  followers: DS.hasMany('Shoplift.User'),
  hashtagbrands: DS.hasMany('Shoplift.Hashtagbrand'),
  recommended: DS.hasMany('Shoplift.User', { key: 'recommended_ids'}),
  htmldescription: function(){
      return this.get('description');//.htmlSafe();
  }.property('description'),
  recentItems: function() {
    var limit = 4
        items = this.get('items');
        
    return items.slice(0, limit);
  }.property('items'),
  user: null,
  exists: function() {
    $.ajax({
      url: "/users",
      type: 'POST',
      data: this,
      context: this
    });/*.success(function(data) {
      this.user = true;
    }).error(function() {
      this.user = false;
    });*/
    return this.user;
  }.property()
});
