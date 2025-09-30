class AddPasswordResetToLibrarians < ActiveRecord::Migration[8.0]
  def change
    add_column :librarians, :password_reset_token, :string
    add_column :librarians, :password_reset_sent_at, :datetime
  end
end
