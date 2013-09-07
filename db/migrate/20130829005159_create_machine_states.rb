class CreateMachineStates < ActiveRecord::Migration
  def change
    create_table :machine_states do |t|

      t.belongs_to :state
      t.belongs_to :machine

      t.timestamps
    end

    drop_table :machines_states
  end
end
