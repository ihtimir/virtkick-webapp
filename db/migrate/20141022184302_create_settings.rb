class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key, unique: true, index: true, null: false
      t.string :val

      t.timestamps null: false
    end
  end
end
