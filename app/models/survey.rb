class Survey < ActiveRecord::Base
  attr_accessible :description, :name, :county_id,
  							 :start_date, :end_date, :sample_size

  belongs_to :county
  has_many :user_moments, dependent: :destroy
  has_many :responses, through: :user_moments

  validates :name, presence: true
  validates :county_id, presence: true

  attr_reader :sample_size
  
  def sample_size=(value)
    @sample_size = value.to_i
  end

  after_create :create_user_moments
  
  def summary_table
    
  end

  private
  def create_user_moments
    users = county.users.participating.map(&:id)
    unless users.empty?
      population = Population.new(users, start_date, end_date)
      @sample_size.times do
        user_moments.create!(user_id: population.random_user,
         moment: population.random_moment)
      end
    end
  end
end
