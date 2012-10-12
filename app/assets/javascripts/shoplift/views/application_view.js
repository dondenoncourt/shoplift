Shoplift.ApplicationView = Ember.View.extend({
  templateName: 'shoplift/templates/application',
  setupComingSoon: function() {
    this.$().on("mouseover", ".coming-soon", function(e) {
      if(e.fromElement === null || (!$(e.fromElement).hasClass("coming-soon-popup") && e.fromElement !== e.currentTarget)) {
        $(this).append('<div class="coming-soon-popup fade-in-fast">Coming soon!</div>');
      }
    });
    this.$().on("mouseout", ".coming-soon", function(e) {
      var that = this;
      if(!$(e.relatedTarget).hasClass("coming-soon-popup") && e.relatedTarget !== e.currentTarget) {
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
