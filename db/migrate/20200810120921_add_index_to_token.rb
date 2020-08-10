class AddIndexToToken < ActiveRecord::Migration[6.0]
  def change
    add_index :password_reset_tokens, :token, unique: true
  end
end
