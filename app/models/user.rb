class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :rememberable, :recoverable, :token_authenticatable, :confirmable,
  # :lockable and :omniauthable
  devise :database_authenticatable, :registerable,
         :trackable, :validatable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  # attr_accessible :title, :body

  attr_accessible :email, :password, :admin, as: :admin

  has_many :activity_logs, dependent: :destroy

  def timeout_in
  	30.minutes
  end

	def to_s
		"#{email} (#{admin? ? "Admin" : "User"})"
	end
end
