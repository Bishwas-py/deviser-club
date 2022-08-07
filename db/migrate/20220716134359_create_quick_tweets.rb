class CreateQuickTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :quick_tweets do |t|
      t.text :content
      t.string :ip_field
      t.integer :watches, default: 0
      
      t.timestamps
    end
  end
end
