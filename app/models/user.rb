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
  has_many :user_moments, dependent: :restrict
  has_many :responses, through: :user_moments

  validates :county_id, presence: :true, unless: :admin
  validates :job_classification_id, presence: :true, unless: :admin

  scope :participating, -> { where("admin = ?", false) }

  def timeout_in
    30.minutes
  end

  def county_name
    self.county.name if county
  end

  def job_title
    self.job_classification.name if job_classification
  end

  def first_active_moment
    user_moments.active.unanswered.order(:moment).first
  end

  def role
    self.admin? ? "Admin" : "User"
  end

	def to_s
    self.email
  end
end
