class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name

      t.timestamps
    end

    create_table :machines_states do |t|
      t.belongs_to :state
      t.belongs_to :machine
      t.timestamps
    end
  end
end
