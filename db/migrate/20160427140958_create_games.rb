class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.json :data, default: {}
      t.string :code, null: false
      t.string :first, null: false
      t.boolean :started, null: false, default: false
      t.timestamps null: false
    end
  end
end
