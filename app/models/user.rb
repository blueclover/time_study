class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :rememberable, :recoverable, :token_authenticatable, :confirmable,
  # :lockable and :omniauthable
  devise :database_authenticatable, :registerable,
         :trackable, :validatable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :county_id, :job_classification_id
  # attr_accessible :title, :body

  attr_accessible :email, :password, :admin, :county_id,
                  :job_classification_id, as: :admin

  belongs_to :county
  belongs_to :job_classification
  has_many :activity_logs, dependent: :destroy

  validates :county_id, presence: :true, unless: :admin
  validates :job_classification_id, presence: :true, unless: :admin

  def timeout_in
    30.minutes
  end

  def county_name
    self.county.name if county
  end

  def role
    self.admin? ? "Admin" : "User"
  end

	def to_s
    self.email
  end
end
