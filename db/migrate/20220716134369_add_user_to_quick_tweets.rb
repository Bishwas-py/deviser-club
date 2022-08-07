class AddUserToQuickTweets < ActiveRecord::Migration[7.0]
  def change
    add_reference :quick_tweets, :user, null: true, foreign_key: true
  end
end
