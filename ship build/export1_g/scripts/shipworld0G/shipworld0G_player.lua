oldInit = init or function() end
oldUpdate = update or function() end


function init()
	oldInit()
	self.oldWorldBreathableFunc = world.breathable
end

function update(dt)
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
		world.breathable = self.oldWorldBreathableFunc
        mcontroller.controlParameters({gravityEnabled = true})
    else
		world.breathable = function(mouthPos) return false end
        mcontroller.clearControls()
        mcontroller.controlParameters({gravityEnabled = false})
    end
end