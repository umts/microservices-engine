class CreateMicroservicesEngineConfigurations < ActiveRecord::Migration
  def change
    create_table :microservices_engine_configurations do |t|

      t.timestamps null: false
    end
  end
end
