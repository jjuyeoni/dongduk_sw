class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :writer
      t.integer :rate
      t.text :content

      t.timestamps
    end
  end
end
