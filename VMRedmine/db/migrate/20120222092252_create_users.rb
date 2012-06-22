class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :language
      t.string :password
      t.string :confirmation

      t.timestamps
    end
  end
end
