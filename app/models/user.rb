class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true
  #validates :name, length: {maximum: 50}
  
  has_many :notes
  has_many :notebooks
  has_many :comments

  def largeimage
    "http://graph.facebook.com/#{self.uid}/picture?type=large/"
  end

  def normalimage
    "http://graph.facebook.com/#{self.uid}/picture?type=normal/"
  end

  def self.find_for_facebook_oauth(omniauth)
    puts "yay!!2"
    if user = User.find_by_email(omniauth.info.email)
      if omniauth.info.image.present?
        user.update_attribute(:image, omniauth.info.image)
      end
      user
    else # Create a user with a stub password. 
      User.create!(:email => omniauth.info.email,
                   :name => omniauth.info.name,
                   :avatar => "https://graph.facebook.com/#{auth["uid"]}/picture?type=large",
                   :password => Devise.friendly_token[0,20])
    end
  end


  # def self.from_omniauth(auth)
  #   puts "yay!!!"
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     user.name = auth.info.name   # assuming the user model has a name
  #     user.update_attribute(:avatar, auth.info.image)
  #     # user.avatar = auth.info.image # assuming the user model has an image
  #     # user.avatar = "http://graph.facebook.com/#{self.uid}/picture?type=normal"
  #     if auth.info.image.present?
  #       puts "yay!"
  #       user.update_attribute(:avatar, auth.info.image)
  #     end
  #   # user
  #   # session["devise.facebook_data"] = env["omniauth.auth"]
  #   end
  # end

  def self.from_omniauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      # user.avatar =  "https://graph.facebook.com/#{auth["uid"]}/picture?type=large/"
      user.save
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else

        user = User.create(
          name:auth.extra.raw_info.name,
          # uid:auth.uid,
          email:auth.info.email,
          avatar: "https://graph.facebook.com/#{auth["uid"]}/picture?type=large/",
          password:Devise.friendly_token[0,20]
          )
      end    
    end
  end



  def self.new_with_session(params, session)
    puts "yay!!5"
    # super.tap do |user|
    #   if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
    #     user.email = data["email"] if user.email.blank?
    #     user.avatar = data.info.image
    #   end
    # end

    super.tap do |user|
      if omniauth = session["devise.facebook_data"]
        user.email = omniauth.info.email
        user.name = omniauth.info.name
        # user.avatar = omniauth.info.image
      end
    end
  end

  has_attached_file :avatar, :styles => { :medium => "400x400>", :thumb => "400x400" }, :default_url => ActionController::Base.helpers.asset_path('missing.png')
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


end
