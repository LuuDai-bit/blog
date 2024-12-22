class CreateAboutMe < ActiveRecord::Migration[7.1]
  def change
    create_table :about_mes do |t|
      t.text :content
      t.text :content_en

      t.timestamps
    end
  end
end
