class RenameQuickTweetsContentToBody < ActiveRecord::Migration[7.0]
  def change
    rename_column :quick_tweets, :content, :body
  end
end
