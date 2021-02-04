class AddRetweetToTweet < ActiveRecord::Migration[6.1]
  def change
    add_reference :tweets, :tweet
  end
end
