Shoplift.Post = DS.Model.extend({
  id: DS.attr('number'),
  name: DS.attr('string'),
  retailer: DS.attr('string'),
  url: DS.attr('string'),
  price: DS.attr('number'),
  comment: DS.attr('string'),
  user_id: DS.attr('number'),
  relifts: DS.attr('number'),
  photo_file_name: DS.attr('string'),
  brand_id: DS.attr('number')
});