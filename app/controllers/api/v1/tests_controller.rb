class Api::V1::TestsController < ApplicationController

    def index
       

        payload = { data: 'test' }


        hmac_secret = 'my$ecretK3y'

        token = JWT.encode payload, hmac_secret, 'HS256'

        

        decoded_token = JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }


        puts decoded_token
        render json: token
    end
end
