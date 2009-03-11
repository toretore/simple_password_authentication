require "digest/sha1"

module SimplePasswordAuthentication


  module ModelMethods


    module User

      attr_accessor :password

      #Returns the salt value. If there is no value, one is generated.
      def salt
        read_attribute(:salt) or returning self.class.generate_salt do |s|
          write_attribute(:salt, s)
        end
      end

      #Force re-generation of salt value. Returns new value.
      def salt!
        returning self.class.generate_salt do |s|
          write_attribute(:salt, s)
        end
      end

      def hashed_password=(pw)
        write_attribute(:hashed_password, self.class.hash_password(pw, salt))
      end

      def password=(pw)
        self.hashed_password = @password = pw
      end

      def correct_password?(pw)
        self.class.hash_password(pw, salt) == hashed_password
      end

    private


      module ClassMethods

        #Hashes a password using a salt value
        def hash_password(pw, salt)
          Digest::SHA1.hexdigest(salt+pw)
        end

        #Generate a random salt value
        def generate_salt
          Digest::SHA1.hexdigest(Time.now.to_f.to_s)
        end

        #Find a user using a username and password
        #Returns the user if successful, false otherwise
        def authenticate(username, password)
          if user = find_by_username(username)
            if user.correct_password?(password)
              user
            end
          end
        end

      end


      module Behavior

        def self.included(model_class)
          model_class.validates_presence_of :username, :hashed_password
          model_class.validates_confirmation_of :password
          model_class.validates_uniqueness_of :username
        end

      end


    end

  end

end
