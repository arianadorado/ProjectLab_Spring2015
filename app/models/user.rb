class User < ActiveRecord::Base
	has_many :projects
	has_many :tasks
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:github]

  def self.from_omniauth(auth)
    # binding.pry 
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # logger.debug('before pry')
      # user.email = auth.info.email
      user.first_name = auth.info.name.split(' ').first
      user.last_name = auth.info.name.split(' ').last
      user.password = user.password_confirmation = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.provider = session["devise.github_data"]['provider']
        user.uid = session["devise.github_data"]['uid']
        user.first_name =  data["name"].split(' ').first
        user.last_name = data["name"].split(' ').last
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
