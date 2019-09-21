class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners do |t|
      t.citext :name, null: false

      t.timestamps
    end

    add_index :owners, :name, unique: true
  end
end
