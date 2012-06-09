class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :message
      t.string :type
      t.references :user

      t.timestamps
    end
  end
end
