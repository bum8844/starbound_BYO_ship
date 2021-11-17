function init()
  animator.setGlobalTag("species", storage.species or "human")
end

function setSpecies(species)
  storage.species = "Capsule"
  animator.setGlobalTag("species", "Capsule")
  return true
end