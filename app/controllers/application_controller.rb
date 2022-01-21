class ApplicationController < ActionController::API
    def encode_token(payload)
        JWT.encode(payload, 'my_s3cr3t')
    end

    def auth_header
        request.headers['Authorization']
    end

    def decode_token(token)

        if auth_header
            token = auth_header.split(' ')[1]
            begin
                JWT.decode(token, 'my_s3cr3t', true, alogorithm: 'HS256' )
            rescue JWT::DecodeError
                nil
            end
        end
    end
end
