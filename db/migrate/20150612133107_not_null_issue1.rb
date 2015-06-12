class NotNullIssue1 < ActiveRecord::Migration
  def change
    change_column :user_notifications, :from_name, :string, :null => true
  end
end
