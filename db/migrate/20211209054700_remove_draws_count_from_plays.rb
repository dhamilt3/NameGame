class RemoveDrawsCountFromPlays < ActiveRecord::Migration[6.0]
  def change
    remove_column :plays, :draws_count
  end
end
