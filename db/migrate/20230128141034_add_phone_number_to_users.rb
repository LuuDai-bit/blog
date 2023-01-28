class AddPhoneNumberToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :phone_number, :string
    User.update_all phone_number: '01234567891'
    change_column :users, :phone_number, :string, null: false
  end

  def down
    remove_column :users, :phone_number
  end
end
