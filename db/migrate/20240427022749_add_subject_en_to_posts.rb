class AddSubjectEnToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :subject_en, :string
  end
end
