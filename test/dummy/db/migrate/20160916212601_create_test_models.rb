class CreateTestModels < ActiveRecord::Migration
  def change
    create_table :test_models do |t|
      t.string :name
      t.decimal :meme

      t.timestamps null: false
    end
  end
end
