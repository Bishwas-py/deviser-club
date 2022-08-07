class RemoveActionTexts < ActiveRecord::Migration[7.0]
  def change
    drop_table :action_text_rich_texts, if_exists: true
  end
end
