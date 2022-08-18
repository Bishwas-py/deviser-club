class AddAppearanceToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :appearance, :integer, default: 0
  end
end
