class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :registerable,
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  validates_presence_of :name
  validates_uniqueness_of :facebook_id, :allow_nil => true

  def self.create_by_omniauth(hash, current_user)
    hash = ActiveSupport::HashWithIndifferentAccess.new hash
    user = User.send("find_by_#{hash[:provider]}_id", hash[:uid])
    unless user
      user = current_user || User.find_by_email(hash[:info][:email]) || User.new( :email => hash[:info][:email], :name => hash[:info][:name] )
      user.send("#{hash[:provider]}_id=", hash[:uid])
      user.save!
    end
    # if hash[:credentials]
    #   hash[:credentials].each{ |key,value|
    #     user.credentials[hash[:provider].to_s+"-"+key.to_s] = value 
    #   }
    # end
    user
  end
  
  def password_required?
    return false if facebook_id
    true
  end

end
