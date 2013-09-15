# -*- encoding : utf-8 -*-
Fabricator(:machine_state) do
  state   { Fabricate(:state)   }
  machine { Fabricate(:machine) }

  reason = 'test'
  note   = 'This is a test note. Just testing notes. Nice thing, huh?'
end
