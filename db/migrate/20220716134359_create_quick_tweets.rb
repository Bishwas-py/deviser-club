class CreateQuickTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :quick_tweets do |t|
      t.text :content

      t.timestamps
    end
  end
end
