Fabricator(:machine_state) do
  state   { Fabricate(:state)   }
  machine { Fabricate(:machine) }
end
