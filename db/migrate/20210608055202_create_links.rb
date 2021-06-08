class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.text :title
      t.string :link, null: false
      t.text :description
      t.string :category
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
