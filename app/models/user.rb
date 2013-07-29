class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :rememberable, :recoverable, :confirmable,
  # :lockable and :omniauthable, :timeoutable, :registerable
  devise :database_authenticatable, :token_authenticatable,
         :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :county_id, :job_classification_id
  # attr_accessible :title, :body

  attr_accessible :email, :password, :admin, :county_id,
                  :job_classification_id, as: :admin

  belongs_to :county
  belongs_to :job_classification
  has_many :activity_logs, dependent: :destroy
  has_many :log_entries, through: :activity_logs

  validates :county_id, presence: :true, unless: :admin
  validates :job_classification_id, presence: :true, unless: :admin

  before_save :ensure_authentication_token

  def favorite_activities
    FavoriteActivity.order(:activity_category_id).map(&:activity_category_id)
  end

  def timeout_in
    30.minutes
  end

  def county_name
    self.county.name if county
  end

  def job_title
    self.job_classification.name if job_classification
  end

  def role
    self.admin? ? "Admin" : "User"
  end

	def to_s
    self.email
  end
end
