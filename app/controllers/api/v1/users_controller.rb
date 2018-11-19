
class Api::V1::UsersController < ApplicationController
    
    
    def create
        email = params[:email]
       
        name = params[:name]
        access_token = User.generate_access_token(email, params[:password])
        user = User.new(
            name: name, 
            email: email, 
            password: params[:password], 
            access_token: access_token
        )
        if user.save 
            render json: {access_token: access_token}
        else
            render json: {data: 'failure'}
        
        end
      
    end

    

    def sign_in
        email = params[:email]  
        user = User.find_by(email: email)
        if user && user.authenticate(params[:password])
            render json: {access_token: user.access_token}
        else
            render json: {result: 'Failure'}
        end
    end

    def get_links
        user = User.find_user_from_token(request)
        user_links = user.youtube_links
        render json: {data: user_links}
    end

    def show
        me = User.find_user_from_token(request)
        user = User.find_by(id: params[:id])
        is_following = false
        if user
            user_info = {id: user.id, name: user.name}
            user_links = user.youtube_links
            following = user.following
            followers = user.followers
            followers.each do |follower|
                if follower.id == me.id
                    is_following = true
                    break
                end
            end
            render json: {
                data: {
                    user_info: user_info,
                    followers: followers,
                    following: following,
                    user_links: user_links,
                    is_following: is_following
                }
            }
        else
            render json: {result: 'Failure'}
        end
    end

    def follow
        current_user = User.find_user_from_token(request)
        user = User.find_by(id: params[:id])
        follow = ActiveRelationship.new(follower_id: current_user.id, followed_id: user.id)
        if follow.save
            render json: {result: 'Success'}
        else
            render json: {result: 'Failure'}
        end
    end

    def unfollow
        current_user = User.find_user_from_token(request)
        user = User.find_by(id: params[:id])
        follow = ActiveRelationship.find_by(followed_id: user.id, follower_id: current_user.id)
        if follow.destroy
            render json: {result: 'Success'}
        else
            render json: {result: 'Failure'}
        end
    end

    


    
end
