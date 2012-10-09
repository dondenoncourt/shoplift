Shoplift.ApplicationView = Ember.View.extend({
  templateName: 'shoplift/templates/application',
  didInsertElement: function() {
    this.$('.coming-soon').tooltip({
      title: 'Coming soon!'
    });
    this.$('.coming-soon').on("hover", function() {
      $(this).tooltip();
      console.log("hello");
    })
  }
});
