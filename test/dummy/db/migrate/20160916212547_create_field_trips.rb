class CreateFieldTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :field_trips do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
