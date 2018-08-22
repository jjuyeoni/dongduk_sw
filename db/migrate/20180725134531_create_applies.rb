class CreateApplies < ActiveRecord::Migration[5.2]
  def change
    create_table :applies do |t|

      t.integer :partner
      t.boolean :matching
      t.string :title
      t.text :content
      t.references :post
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
