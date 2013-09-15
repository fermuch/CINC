# -*- encoding : utf-8 -*-
class Machine < ActiveRecord::Base
  belongs_to :student
  has_many :machine_states
  has_many :states, :through => :machine_states
end
