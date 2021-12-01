class AddDrawCountToDraws < ActiveRecord::Migration[6.0]
  def change
    add_column :draws, :draw_count, :integer
  end
end
