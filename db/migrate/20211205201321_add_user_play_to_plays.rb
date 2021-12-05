class AddUserPlayToPlays < ActiveRecord::Migration[6.0]
  def change
    add_column :plays, :user_play, :integer
  end
end
