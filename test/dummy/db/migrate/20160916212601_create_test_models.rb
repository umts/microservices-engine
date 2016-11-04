class CreateTestModels < ActiveRecord::Migration[5.0]
  def change
    create_table :test_models do |t|
      t.string :name
      t.decimal :meme

      t.timestamps null: false
    end
  end
end
