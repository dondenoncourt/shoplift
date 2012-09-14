Shoplift.Item.FIXTURES = [
  {
	id: 1,
	name: "Something 1",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "http://davidmazza.net/shoplift/images/product-img.png",
	views: "2100",
	relifts: "5",
	visits: "23",
	user_id: 2,
	brand: {
		id: 12, //this is a hashtagbrand id
		value: "Macy's"
	},
	hashtagbrand_ids: [1, 2, 4, 5]
  }, 
  { 
	id: 2,
	name: "Something 2",
	relifts: "5",
	brand: "Sears",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "http://davidmazza.net/shoplift/images/product-img.png",
	user_id: 2,
	brand: {
		id: 18, //this is a hashtagbrand id
		value: "Sears"
	},
	hashtagbrand_ids: [1, 2, 4, 5]
  },
  { 
	id: 3,
	name: "Something 3",
	relifts: "5",
	brand: "Walmart",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "http://davidmazza.net/shoplift/images/product-img.png",
	user_id: 1,
	brand: {
		id: 19, //this is a hashtagbrand id
		value: "Walmart"
	},
	hashtagbrand_ids: [1, 2, 4, 5]
  },
  { 
	id: 4,
	name: "Something 4",
	relifts: "5",
	brand: "Caldor",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "http://davidmazza.net/shoplift/images/product-img.png",
	user_id: 1,
	brand: {
		id: 12, //this is a hashtagbrand id
		value: "Macy's"
	},
	hashtagbrand_ids: [1, 2, 4, 5]
  },
  { 
	id: 5,
	name: "Something 5",
	relifts: "5",
	brand: "Family Dollar",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "http://davidmazza.net/shoplift/images/product-img.png",
	user_id: 2,
	brand: {
		id: 12, //this is a hashtagbrand id
		value: "Macy's"
	},
	hashtagbrand_ids: [1, 2, 4, 5]
  },
  { 
	id: 6,
	name: "Something 6",
	relifts: "5",
	brand: "Salvation Army",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "http://davidmazza.net/shoplift/images/product-img.png",
	user_id: 1,
	brand: {
		id: 12, //this is a hashtagbrand id
		value: "Macy's"
	},
	hashtagbrand_ids: [1, 2, 4, 5]
  }
];

Shoplift.User.FIXTURES = [
  {
	id: 1,
	email: "myriah@jackson.com",
	username: "mjackson",
	full_name: "Myriah Jackson",
	description: "how many gallons <br />of Edo's rain did you drink? <br />cuckoo",
	avatar_url_small: "http://davidmazza.net/shoplift/images/jane-randall.jpg",
	followee_count: "201",
	follower_count: "56",
	item_ids: [3, 4, 6],
	followee_ids: [2, 3],
	follower_ids: [2],
	hashtagbrand_ids: [1, 3, 4]
  },
  {
	id: 2,
	email: "nadine@pert.com",
	username: "npert",
	full_name: "Nadine Pert",
	description: "I do enjoy cake",
	avatar_url_small: "http://davidmazza.net/shoplift/images/jane-randall.jpg",
	followee_count: "136",
	follower_count: "1304",
	item_ids: [1, 2, 5],
	followee_ids: [1, 3],
	follower_ids: [1],
	hashtagbrand_ids: [1, 2]
  },
  {
	id: 3,
	email: "nadine@pert.com",
	username: "npert",
	full_name: "Nadine Pert",
	description: "Something else",
	avatar_url_small: "http://davidmazza.net/shoplift/images/jane-randall.jpg",
	followee_count: "136",
	follower_count: "1304",
	item_ids: [],
	followee_ids: [],
	follower_ids: [1, 2],
	hashtagbrand_ids: [1, 2, 3]
  }
];

Shoplift.Hashtagbrand.FIXTURES = [
	{
		id: 1,
		name: "summer",
		image: "http://davidmazza.net/shoplift/images/product-img.png",
		item_ids: [1, 2, 5],
		user_ids: [1, 2, 3]
	},
	{
		id: 2,
		name: "beach",
		image: "http://davidmazza.net/shoplift/images/product-img.png",
		item_ids: [1, 2, 4, 6],
		user_ids: [2, 3]
	},
	{
		id: 3,
		name: "Sears",
		image: "http://davidmazza.net/shoplift/images/product-img.png",
		item_ids: [2, 4, 6],
		user_ids: [1, 3]
	},
	{
		id: 4,
		name: "warm",
		image: "http://davidmazza.net/shoplift/images/product-img.png",
		item_ids: [5, 6],
		user_ids: [1]
	}
];