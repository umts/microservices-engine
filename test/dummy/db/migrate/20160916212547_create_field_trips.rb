class CreateFieldTrips < ActiveRecord::Migration
  def change
    create_table :field_trips do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
