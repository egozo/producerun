class NotNullIssue < ActiveRecord::Migration
  def change
    change_column :user_notifications, :from_email, :string, :null => true
    change_column :user_notifications, :from_name, :string, :null => true

  end
end
