class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    before_create :create_remember_token
    
    #comments and posts
    has_many :microposts, dependent: :destroy
    has_many :comments

    #relationships
    has_many :relationships, foreign_key: "follower_id", dependent: :destroy
    has_many :followed_users, through: :relationships, source: :followed
    has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
    has_many :followers, through: :reverse_relationships, source: :follower

    #encrypt password
    include BCrypt
    attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :user_name, :user_bio
    attr_accessor :password
    before_save :encrypt_password

    #validate user params
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates_confirmation_of :password , :message => "Passwords do not match."
    validates_presence_of :password, :message => "Please Enter a Password"
    validates_presence_of :email,:message=>"Email ID Field cannot be blank", format: { with: VALID_EMAIL_REGEX }
    validates_uniqueness_of :email, :message => "Sorry this Email ID is already registered."
    validates_presence_of :user_name,:message=>"Username Field cannot be blank"
    validates_uniqueness_of :user_name, :message => "Sorry this Username is already registered."

    def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
    end

    def encrypt_password
        if password.present?
          self.password_salt = BCrypt::Engine.generate_salt
          self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
        end
    end

    def should_validate_password?
      updating_password || new_record?
    end
    
    #following/follower
    def following?(other_user)
        relationships.find_by(followed_id: other_user.id)
    end

    def follow!(other_user)
        relationships.create!(followed_id: other_user.id)
    end
    def unfollow!(other_user)
        relationships.find_by(followed_id: other_user.id).destroy!
    end

    #login
    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end

    def User.encrypt(token)
        Digest::SHA1.hexdigest(token.to_s)
    end

    #feed
    def feed
        Micropost.from_users_followed_by(self)
    end

    #search
    def self.search(query)
        where("user_name like ?", "%#{query}%")
    end

    private

        def create_remember_token
          self.remember_token = User.encrypt(User.new_remember_token)
        end
end
