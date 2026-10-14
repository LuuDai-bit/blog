class CreateDraftPosts < ActiveRecord::Migration[8.1]
  def change
    create_table :draft_posts do |t|
      t.string :subject
      t.string :subject_en
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
