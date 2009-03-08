module SimpleAuthentication


  class PasswordAuthenticator < Authenticator


    def authentication_possible?
      !params.values_at(:username, :password).any?{|v| v.blank? }
    end


    def authenticate
      User.authenticate(params[:username], params[:password])
    end


  end


end
