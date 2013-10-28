class User < ActiveRecord::Base
    has_many :relationships, foreign_key: "follower_id", dependent: :destroy
    has_many :followed_users, through: :relationships, source: :followed
    has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent:   :destroy
    has_many :followers, through: :reverse_relationships, source: :follower

    include BCrypt
    attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :user_name, :user_bio
    attr_accessor :password
    before_save :encrypt_password

    validates_confirmation_of :password , :message => "Passwords donot match."
    validates_presence_of :password, :message => "Please Enter a Password"
    validates_presence_of :email,:message=>"Email ID Field cannot be blank"
    validates_uniqueness_of :email, :message => "Sorry this Email ID is already registered."
    validates_presence_of :user_name,:message=>"Username Field cannot be blank"
    validates_uniqueness_of :user_name, :message => "Sorry this Username is already registered."
    validates_presence_of :first_name , :message => "First Name Field cannot be blank"
    validates_presence_of :last_name, :message => "Last Name Field cannot be blank"

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
    def following?(other_user)
        relationships.find_by(followed_id: other_user.id)
    end

    def follow!(other_user)
        relationships.create!(followed_id: other_user.id)
    end
    def unfollow!(other_user)
        relationships.find_by(followed_id: other_user.id).destroy!
    end
end
