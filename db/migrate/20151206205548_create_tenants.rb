class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :room, index: true, foreign_key: true
      t.integer :rent_cents
      t.date :start_at
      t.date :end_at

      t.timestamps null: false
    end
  end
end
