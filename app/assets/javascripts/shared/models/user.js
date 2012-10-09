Shoplift.User = DS.Model.extend({
  email: DS.attr('string'),
  sngupState: DS.attr('string'),
  password: DS.attr('string'),
  passwordConfirmation: DS.attr('string'),
  vanityUrl: DS.attr('string'),
  fullName: DS.attr('string'),
  description: DS.attr('string'),
  biography: DS.attr('string'),
  country: DS.attr('string'),
  zipcode: DS.attr('string'),
  sex: DS.attr('string'),
  gender: function(key, value) {
    var MALE = "true",
        FEMALE = "false",
        NIETHER = "";
        
    if(arguments.length === 1) {
      if(this.get("sex") === MALE) return "male";
      if(this.get("sex") === FEMALE) return "female";
      if(this.get("sex") === NIETHER) return "niether";
    }
    else {
      if(value === "male") this.set("sex", MALE);
      if(value === "female") this.set("sex", FEMALE);
      if(value === "niether") this.set("sex", NIETHER);
    }
  }.property('sex'),
  month: DS.attr('number'), //, {key: "birthdate(2i)"}), //month
  day: DS.attr('number'), //, {key: "birthdate(3i)"}), //day
  year: DS.attr('number'), //, {key: "birthdate(1i)"}), //year
  tos: DS.attr('number'),
  originalUrl: DS.attr('string'),
  largeUrl: DS.attr('string'),
  thumbUrl: DS.attr('string'),
  url: DS.attr('string'),
  countOfPosts: DS.attr('number'),
  followerCount: (function(){ this.get('followers.length'); }).property('followers.length'),
  followeeCount: (function(){ this.get('followees.length'); }).property('followees.length'),
  items: DS.hasMany('Shoplift.Item'),
  followees: DS.hasMany('Shoplift.User'),
  followers: DS.hasMany('Shoplift.User'),
  hashtagbrands: DS.hasMany('Shoplift.Hashtagbrand'),
  recommended: DS.hasMany('Shoplift.User', { key: 'recommended_ids'}),
  htmldescription: function(){
      return this.get('biography');//.htmlSafe();
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
