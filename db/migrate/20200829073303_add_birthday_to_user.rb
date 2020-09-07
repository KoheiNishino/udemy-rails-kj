class AddBirthdayToUser < ActiveRecord::Migration[5.2]
  def change
    # Usersテーブルにbirthdayカラムを追加する
    add_column :users, :birthday, :date
  end
end
