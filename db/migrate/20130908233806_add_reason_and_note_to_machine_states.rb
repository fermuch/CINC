class AddReasonAndNoteToMachineStates < ActiveRecord::Migration
  def change
    add_column :machine_states, :reason, :string
    add_column :machine_states, :note, :text
  end
end
