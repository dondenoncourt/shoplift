Shoplift.Item = DS.Model.extend({
  id: DS.attr('number'),
  relifts: DS.attr('number'),
  name: DS.attr('string'),
  comment: DS.attr('string'),
  url: DS.attr('string'),
  price: DS.attr('number'),
  photoFileName: DS.attr('string'),
  status: DS.attr("number"),
  views: DS.attr("number"),
  visits: DS.attr("number")
});