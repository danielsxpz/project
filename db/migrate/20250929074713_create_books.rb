class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :author, null: false
      t.string :title, null: false
      t.string :status, default: 'Disponível'
      t.text :observations
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
