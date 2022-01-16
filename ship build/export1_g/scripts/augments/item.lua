Item = {}
Item.__index  = Item

function Item.new(...)
  local self = setmetatable({}, Item)
  self:init(...)
  return self
end

function Item:init(descriptor)
  self.name = descriptor.name
  self.count = descriptor.count or 1
  self.parameters = descriptor.parameters or {}
  self.config = root.itemConfig(descriptor).config
end

function Item:type()
  return root.itemType(self.name)
end

function Item:descriptor()
  return {
      name = self.name,
      count = self.count,
      parameters = self.parameters
    }
end

function Item:instanceValue(name, default)
  return sb.jsonQuery(self.parameters, name) or sb.jsonQuery(self.config, name) or default
end

function Item:setInstanceValue(name, value)
  self.parameters[name] = value
end

--Sj Start--
local oldUpdate = update or function() end

function OutOfShipCheck(dt)
  oldUpdate(dt)

  if world.type() == "unknown" then
    if not world.tileIsOccupied(mcontroller.position(), false) then
        lifeSupport(false)
    else
        lifeSupport(true)
    end
  end
end

function lifeSupport(isOn)
    if isOn then
        mcontroller.controlParameters({gravityEnabled = true})
    else
        mcontroller.clearControls()
        mcontroller.controlParameters({gravityEnabled = false})
    end
end
--Sj End--

function update(dt)
  --Sj Start--
  OutOfShipCheck(dt)
  --Sj End--