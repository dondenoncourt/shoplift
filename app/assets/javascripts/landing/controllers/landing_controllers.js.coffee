
Landing.ApplicationController = Ember.ObjectController.extend
  content: Shoplift.User.createRecord()
  genders: ["", "male", "female", "neither"]
  countries: ["United States", "Canada", "Mexico"],
  months: [
    {id: 0, month: ""},
    {id: 1, month: "January"},
    {id: 2, month: "February"},
    {id: 3, month: "March"},
    {id: 4, month: "April"},
    {id: 5, month: "May"},
    {id: 6, month: "June"},
    {id: 7, month: "July"},
    {id: 8, month: "August"},
    {id: 9, month: "September"},
    {id: 10, month: "October"},
    {id: 11, month: "November"},
    {id: 12, month: "December"}
  ]
  days: ["", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]
  years: (year for year in [2010..1900])
  
  whoami: ->
    $.ajax
      url: '/users/whoami',
      type: 'GET',
      context: this,
    .done( (response) =>
        this.set('content', Shoplift.store.find(Shoplift.User, response.user));
    )
    .fail( =>
        
    )