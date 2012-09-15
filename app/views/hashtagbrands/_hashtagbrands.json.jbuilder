json.hashtagbrands @hashtagbrands do |json, hashtagbrand|
  json.partial! 'hashtagbrand', :@hashtagbrand => hashtagbrand
end
