class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.belongs_to :photographable, index: true
      t.string :photographable_type
      t.text :description

      t.timestamps null: false
    end
  end
end
