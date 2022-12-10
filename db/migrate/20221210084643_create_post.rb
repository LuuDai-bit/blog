class CreatePost < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :subject, null: false
      t.json :content, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
