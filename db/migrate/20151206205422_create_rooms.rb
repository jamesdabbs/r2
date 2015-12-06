class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.belongs_to :unit, index: true, foreign_key: true
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
