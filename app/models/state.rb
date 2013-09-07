class State < ActiveRecord::Base
  has_many :machine_states
  has_many :machines, :through => :machine_states
end
