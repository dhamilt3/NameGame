class CreatePlays < ActiveRecord::Migration[6.0]
  def change
    create_table :plays do |t|
      t.integer :user_id
      t.string :correct_sum
      t.string :incorrect_sum
      t.string :result
      t.integer :draws_count

      t.timestamps
    end
  end
end
