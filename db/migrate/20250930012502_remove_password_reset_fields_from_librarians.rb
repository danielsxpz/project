class RemovePasswordResetFieldsFromLibrarians < ActiveRecord::Migration[8.0]
  def change
    remove_column :librarians, :password_reset_token, :string
    remove_column :librarians, :password_reset_sent_at, :datetime
  end
end
