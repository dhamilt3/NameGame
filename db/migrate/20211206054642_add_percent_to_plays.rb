class AddPercentToPlays < ActiveRecord::Migration[6.0]
  def change
    add_column :plays, :percent, :float
  end
end
