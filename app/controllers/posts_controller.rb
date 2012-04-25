
class PostsController < ApplicationController
  def myposts
    puts 'got here'
    @me = User.find(1)
    @me.posts.find_all().each {|it| p it}
    render :text => 'myposts ran'
  end
end
