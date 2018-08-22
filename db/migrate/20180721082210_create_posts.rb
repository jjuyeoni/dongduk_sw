class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :category
      t.string :address
      t.text :candays
      t.string :lat
      t.string :lon
      t.references :user, foreign_key: true
      t.string :image
      
      t.timestamps
    end
  end
end