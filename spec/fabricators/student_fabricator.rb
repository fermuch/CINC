Fabricator(:student) do
  name "Test"
  cuil "301111111119"

  machine { Fabricate(:machine) }
end
