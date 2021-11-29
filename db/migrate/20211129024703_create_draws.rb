class CreateDraws < ActiveRecord::Migration[6.0]
  def change
    create_table :draws do |t|
      t.integer :roster_id
      t.string :name_match
      t.string :name_attempt
      t.integer :play_id

      t.timestamps
    end
  end
end
