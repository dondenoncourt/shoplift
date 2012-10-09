Shoplift.ApplicationView = Ember.View.extend({
  templateName: 'shoplift/templates/application',
  setupComingSoon: function() {
    this.$('.coming-soon').on("mouseover", function(e) {
      if(!$(e.fromElement).hasClass("coming-soon") && !$(e.fromElement).hasClass("coming-soon-popup")) {
        $(this).append('<div class="coming-soon-popup fade-in-fast">Coming soon!</div>');
      }
    });
    this.$('.coming-soon').on("mouseout", function(e) {
      var that = this;
      if(!$(e.relatedTarget).hasClass("coming-soon-popup") && !$(e.relatedTarget).hasClass("coming-soon")) {
        $(this).children(".coming-soon-popup").removeClass('fade-in-fast');
        $(this).children(".coming-soon-popup").addClass('fade-out-fast');
        setTimeout(function() {
          $(that).children(".coming-soon-popup").remove();
        }, 200);
      }
    });
  },
  destroyComingSoon: function() {
    this.$(".coming-soon").off("mouseover");
    this.$(".coming-soon").off("mouseout");
  },
  didInsertElement: function() {
    this.setupComingSoon();
  },
  willDestroyElement: function() {
    this.destroyComingSoon()
  }
});
