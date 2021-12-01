class AddDrawTotalToDraws < ActiveRecord::Migration[6.0]
  def change
    add_column :draws, :draw_total, :integer
  end
end
