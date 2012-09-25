Shoplift.User = DS.Model.extend({
  email: DS.attr('string'),
  vanityUrl: DS.attr('string'),
  fullName: DS.attr('string'),
  description: DS.attr('string'),
  avatarUrlSmall: DS.attr('string'),
  url: DS.attr('string'),
  followeeCount: DS.attr('number'),
  followerCount: DS.attr('number'),
  items: DS.hasMany('Shoplift.Item', { key: 'item_ids' }),
  followees: DS.hasMany('Shoplift.User', { key: 'followee_ids' }),
  followers: DS.hasMany('Shoplift.User', { key: 'follower_ids' }),
  hashtagbrands: DS.hasMany('Shoplift.Hashtagbrand', { key: 'hashtagbrand_ids' }),
  recommended: DS.hasMany('Shoplift.User', { key: 'recommended_ids'}),
  htmldescription: function(){
      return this.get('description');//.htmlSafe();
  }.property('description')
});