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

Shoplift.Item = DS.Model.extend({
  name: DS.attr('string'),
  relifts: DS.attr('number'),
  brand: DS.attr('string'),
  comment: DS.attr('string'),
  url: DS.attr('string'),
  price: DS.attr('number'),
  photoFileName: DS.attr('string'),
  user: DS.belongsTo('Shoplift.User')
});