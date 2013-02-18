class CreateJobClassifications < ActiveRecord::Migration
  def change
    create_table :job_classifications do |t|
      t.string :name
    end
  end
end
