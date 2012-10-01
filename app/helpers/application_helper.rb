module ApplicationHelper
  def compress_js(js)
    # this make assumptions that the JavaScript it is compressing is strict an valid
    js.gsub(/\n/,'').gsub(/\s+/,' ').gsub(/\s?(\,|\+|=|\{|\}|\(|\)|;)\s?/,'\1')
  end
end
