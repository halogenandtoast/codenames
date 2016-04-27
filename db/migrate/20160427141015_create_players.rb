class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :ip_address, null: false
      t.string :name, null: false
      t.string :color
      t.belongs_to :game, index: true, foreign_key: true
      t.boolean :spymaster

      t.timestamps null: false
    end
  end
end
