class AddIpFieldToComment < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :ip_field, :string
  end
end
