class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.string :password_hash, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    # NOTE: not asked, but I'd love to do this
    # add_index :users, :username, unique: true
  end
end
