Shoplift.Item.FIXTURES = [
  {
	id: "1",
	name: "Something 1",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "img/item-box-product-image.jpg",
	views: "2100",
	relifts: "5",
	visits: "23",
	user_id: "2",
	brand: {
		id: 12, //this is a hashtagbrand id
		value: "Macy's"
	},
	hashtagbrand_ids: ["1", "2", "4", "5"]
  }, 
  { 
	id: "2",
	name: "Something 2",
	relifts: "5",
	brand: "Sears",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "img/item-box-product-image.jpg",
	user_id: "2",
	brand: {
		id: 18, //this is a hashtagbrand id
		value: "Sears"
	},
	hashtagbrand_ids: ["1", "2", "4", "5"]
  },
  { 
	id: "3",
	name: "Something 3",
	relifts: "5",
	brand: "Walmart",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "img/item-box-product-image.jpg",
	user_id: "3",
	brand: {
		id: 19, //this is a hashtagbrand id
		value: "Walmart"
	},
	hashtagbrand_ids: ["1", "2", "4", "5"]
  },
  { 
	id: "4",
	name: "Something 4",
	relifts: "5",
	brand: "Caldor",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "img/item-box-product-image.jpg",
	user_id: "1",
	brand: {
		id: 12, //this is a hashtagbrand id
		value: "Macy's"
	},
	hashtagbrand_ids: ["1", "2", "4", "5"]
  },
  { 
	id: "5",
	name: "Something 5",
	relifts: "5",
	brand: "Family Dollar",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "img/item-box-product-image.jpg",
	user_id: "2",
	brand: {
		id: 12, //this is a hashtagbrand id
		value: "Macy's"
	},
	hashtagbrand_ids: ["1", "2", "4", "5"]
  },
  { 
	id: "6",
	name: "Something 6",
	relifts: "5",
	brand: "Salvation Army",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "img/item-box-product-image.jpg",
	user_id: "1",
	brand: {
		id: 12, //this is a hashtagbrand id
		value: "Macy's"
	},
	hashtagbrand_ids: ["1", "2", "4", "5"]
  }
];

Shoplift.User.FIXTURES = [
  {
	id: "1",
	email: "myriah@jackson.com",
	username: "mjackson",
	full_name: "Myriah Jackson",
	description: "I'm just as interested in fasion as I am in marketing! This are my products.",
	avatar_url_small: "http://davidmazza.net/shoplift/images/jane-randall.jpg",
	followee_count: "201",
	follower_count: "56",
	item_ids: ["3", "4", "6", "4", "6"], //, 3, 4, 3, 6, 4, 3],
	followee_ids: ["2", "3"],
	follower_ids: ["2"],
	hashtagbrand_ids: ["1", "2", "3", "4", "1", "2", "3", "4", "4", "3", "2", "1"]
  },
  {
	id: "2",
	email: "nadine@pert.com",
	username: "npert",
	full_name: "Nadine Pert",
	description: "My description would go here if I had one.",
	avatar_url_small: "http://davidmazza.net/shoplift/images/jane-randall.jpg",
	followee_count: "136",
	follower_count: "1304",
	item_ids: ["1", "2", "5", "4", "3"],
	followee_ids: ["1", "3"],
	follower_ids: ["1"],
	hashtagbrand_ids: ["1", "2"],
	recommended_ids: ["3"]
  },
  {
	id: "3",
	email: "nadine@pert.com",
	username: "npert",
	full_name: "Julia Roberts",
	description: "This is a description, I just haven't written anything for it yet.",
	avatar_url_small: "http://davidmazza.net/shoplift/images/jane-randall.jpg",
	followee_count: "136",
	follower_count: "1304",
	item_ids: ["2", "4", "1", "3", "2"],
	followee_ids: ["2"],
	follower_ids: ["1", "2", "1", "1", "2", "3"],
	hashtagbrand_ids: ["1", "2", "3"]
  },
  {
	id: "4",
	email: "nadine@pert.com",
	username: "npert",
	full_name: "Someone Else",
	description: "This is a description, I just haven't written anything for it yet.",
	avatar_url_small: "http://davidmazza.net/shoplift/images/jane-randall.jpg",
	followee_count: "136",
	follower_count: "1304",
	item_ids: ["2", "4", "1", "3", "2"],
	followee_ids: ["2"],
	follower_ids: ["1", "2", "1", "1", "2", "3"],
	hashtagbrand_ids: ["1", "2", "3"]
  },
  {
	id: "5",
	email: "nadine@pert.com",
	username: "npert",
	full_name: "David Mazza",
	description: "This is a description, I just haven't written anything for it yet.",
	avatar_url_small: "http://davidmazza.net/shoplift/images/jane-randall.jpg",
	followee_count: "136",
	follower_count: "1304",
	item_ids: ["2", "4", "1", "3", "2"],
	followee_ids: ["2"],
	follower_ids: ["1", "2", "1", "1", "2", "3"],
	hashtagbrand_ids: ["1", "2", "3"]
  },
  {
	id: "6",
	email: "nadine@pert.com",
	username: "npert",
	full_name: "Brandon Fail",
	description: "This is a description, I just haven't written anything for it yet.",
	avatar_url_small: "http://davidmazza.net/shoplift/images/jane-randall.jpg",
	followee_count: "136",
	follower_count: "1304",
	item_ids: ["2", "4", "1", "3", "2"],
	followee_ids: ["2"],
	follower_ids: ["1", "2", "1", "1", "2", "3"],
	hashtagbrand_ids: ["1", "2", "3"]
  }
];

Shoplift.Hashtagbrand.FIXTURES = [
	{
		id: "1",
		value: "summer",
		image: "img/item-box-product-image.jpg",
		item_ids: ["1", "2", "5"],
		user_ids: ["1", "2", "3"],
		related_ids: ["2", "3", "4", "3"]
	},
	{
		id: "2",
		value: "beach",
		image: "img/item-box-product-image.jpg",
		item_ids: ["1", "2", "4", "6"],
		user_ids: ["2", "3"],
		related_ids: ["1", "3", "1", "3"]
	},
	{
		id: "3",
		value: "Sears",
		image: "img/item-box-product-image.jpg",
		item_ids: ["2", "4", "6"],
		user_ids: ["1", "3"],
		related_ids: ["2", "1", "4", "2"]
	},
	{
		id: "4",
		value: "warm",
		image: "img/item-box-product-image.jpg",
		item_ids: ["5", "6"],
		user_ids: ["1"],
		related_ids: ["1", "3", "1", "3"]
	}
];