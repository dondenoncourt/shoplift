Shoplift.Item.FIXTURES = [
  {
	id: 1,
	name: "Something 1",
	relifts: "5",
	brand: "Macy's",
	comment: "I love it",
	url: "http://google.com",
	price: "88",
	photo_file_name: "http://davidmazza.net/shoplift/images/product-img.png",
	user_id: 2
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
	user_id: 2
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
	user_id: 1
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
	user_id: 1
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
	user_id: 2
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
	user_id: 1
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
	follower_ids: [2]
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
	follower_ids: [1]
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
	follower_ids: [1, 2]
  }
];