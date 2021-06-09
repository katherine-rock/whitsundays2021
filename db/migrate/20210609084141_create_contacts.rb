class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :category
      t.string :email
      t.string :phone
      t.string :company
      t.text :comment
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
