class Api::V1::YoutubeLinksController < ApplicationController
   

    def index
        links = YoutubeLink.all
        results = []
        links.each do |link|
            item = {}
            user = link.user
            item[:user_id] = user.id
            item[:user_name] = user.name
            item[:url] = link.url
            item[:video_id] = link.video_id
            results.push(item)
        end

        render json: {data: results}
    end 
    
    def create 
        url = params[:url]     
        video_id = url.split('?v=')[1][0...11]
        user = User.find_user_from_token(request)
        if user 
            youtube_link = YoutubeLink.new(url: url, user_id: user.id, video_id: video_id)    
            if youtube_link.save
                render json: {result: 'success'}
            end
        else 
            render json: {result: 'Failure'}
        end
    end

    

end
