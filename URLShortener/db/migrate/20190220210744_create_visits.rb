class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.integer :user_id, null: false
      t.integer :shorten_url_id, null: false 


    end
  end
end
