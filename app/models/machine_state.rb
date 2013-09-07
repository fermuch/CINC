class MachineState < ActiveRecord::Base
  belongs_to :state
  belongs_to :machine
end
