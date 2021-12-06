class AddDrawResultToDraws < ActiveRecord::Migration[6.0]
  def change
      add_column :draws, :draw_result, :integer
  end
end
