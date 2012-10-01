

Shoplift.store = DS.Store.create({
  revision: 4,
  adapter: DS.RESTAdapter.create({
    bulkCommit: true,
    mappings: {
      hashtagbrands: Shoplift.Hashtagbrand
    }
  }),
});

