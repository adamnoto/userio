class CreatePasswordResetTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :password_reset_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token, null: false

      t.timestamps
    end
  end
end
