class RemoveResultFromPlays < ActiveRecord::Migration[6.0]
  def change
    remove_column :plays, :result
  end
end
