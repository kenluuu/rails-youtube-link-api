
class User < ApplicationRecord
    has_many :youtube_links 
    has_many :active_relationships, foreign_key: 'follower_id', dependent: :destroy 
    # has_many :following, 
    has_many :passive_relationships, class_name: "ActiveRelationship", foreign_key: 'followed_id', dependent: :destroy
    has_many :following, through: :active_relationships, source: 'followed'
    has_many :followers, through: :passive_relationships, source: 'follower'
    has_secure_password
    validates :email, uniqueness: true
    def self.generate_access_token(email, password)
        payload = { email: email, password: password }


        hmac_secret = 'my$ecretK3y'

        token = JWT.encode payload, hmac_secret, 'HS256'

        return token
    end



    def self.find_user_from_token(request)
        token = request.headers["Authorization"]
        return User.find_by(access_token: token)
        
    end

  
end
