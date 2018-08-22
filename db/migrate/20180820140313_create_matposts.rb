class CreateMatposts < ActiveRecord::Migration[5.2]
  def change
    create_table :matposts do |t|
      t.references :post
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
