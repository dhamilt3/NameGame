class AddDrawCorrectToDraws < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :draw_correct, :integer
  end
end
