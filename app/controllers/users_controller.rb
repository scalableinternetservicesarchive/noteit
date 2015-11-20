class UsersController < ApplicationController
before_action :authenticate_user!

def index
	@users = User.paginate(page: params[:page])
end

def show
	@user = User.find(params[:id])
end

def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'users/show_follow'
end

def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'users/show_follow'
end

def feed
    @feed_items = current_user.feed.paginate(page: params[:page])
end

end
