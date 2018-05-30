pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- it begins!
-- ava~

-- the init method is called
-- when the cartridge is 
-- first loaded. initialisation
-- code goes here
function _init()
	-- adds an item to the 
	-- pause menu
	menuitem(1, "next demo", loadnextdemo)
end

-- called once per frame at 30 
-- fps game logic should go here
-- any changes to state, 
-- positions,variables, etc...
function _update()

end


-- if defined, called once per 
-- frame at 60 fps. use instead
-- of _update() which runs at 30
function _update60()

end

-- generally called once per 
-- frame at 30 or 60 fps 
-- depending on update method 
-- defined. if update and draw
-- take over the chosen frame
-- rate draw will be skipped,
-- and update will be called
-- again.
function _draw()
	-- clears the screen, 
	-- 12 is the light blue colour
	cls(12)
	-- prints 'template' at (96,122)
	-- with the color 7 (white)
	print("template", 96, 122, 7)
end

-->8
-- demo switching

function loadnextdemo()
	-- loads the next demo cartridge
	-- leaving a breadcrumb back to this demo
	load('sprite.p8', 'previous demo')	
end
__map__
0000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
