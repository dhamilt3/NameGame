class CreateRosters < ActiveRecord::Migration[6.0]
  def change
    create_table :rosters do |t|
      t.integer :badge_number
      t.string :first_name
      t.string :last_name
      t.string :preferred_name
      t.integer :shift
      t.string :department
      t.string :role
      t.string :image
      t.integer :draws_count

      t.timestamps
    end
  end
end
