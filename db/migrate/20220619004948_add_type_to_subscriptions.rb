class AddTypeToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :type, :string
  end
end
