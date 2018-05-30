pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- there's more to the world
-- ava~

step = .03333 -- our framerate, 1/30

function _init()
	menuitem(1, "next demo", loadnextdemo)
	frames = { 3, 4, 2, 1}
	frametime	= 0
	frameidx = 1
	speed = 30
	x,y = 60, 60
	walking = false
	left = false
	
	jumping = false
	onground = false
	jumptime = 0
	crouched = false
	camx = 0
end

function _update()
	frametime += 1
	walking = false
	jumping = false
	crouched = false
	onground = false
	
	-- store the player's map cell in
	-- a local table variable.	
	if(btn(0) and x > 0 and not hardright(getleftcell())) then
		x -= speed * step 
		walking = true 
		left = true
		if(camx > 0 and x - camx < 28) camx -= speed * step
	end
	if(btn(1) and x < 248 and not hardleft(getrightcell())) then
		x += speed * step 
		walking = true 
		left = false
		if(camx + 128 < 256 and x - camx > 100) camx += speed * step
	end
	
	local pcell = getplayercell()
	local belowcells = getbottomcells()
	if(hardtop(belowcells.a) or hardtop(belowcells.b)) then
		onground = true
	end
	
	if(btn(3) and not walking and onground) then
		frameidx = 9
		crouched = true
	end
	
	if(btn(5) and (onground or jumptime < 15)) then
		jumping = true
		onground = false
		y -= speed * step
	end
	
	if(not onground) then
		if(jumping) then
			frameidx = 5
			jumptime += 1
		else
			frameidx = 6
			y += speed * step
			jumptime = 15			
		end
	else
		jumptime = 0
		if(walking) then
			if(frametime > 5) then
					frametime = 0
				 frameidx += 1
			end
			if(frameidx > 4) then
				frameidx = 1
			end
		elseif(not crouched) then
			frametime = 0
			frameidx = 0
		end
	end
end

function _draw()
	camera(camx, 0)
	cls(12)
	map(0,0,0,28,32,16)
	if(onground and walking) then
		spr(frames[frameidx], x, y, 1, 1, left)
	else
		spr(frameidx, x, y, 1, 1, left) 
	end
	camera(0, 0)
	print("simple collisions", 60, 122, 7)
end

-- a local function to get the
-- player's effective map cell
function getplayercell()
	local xo = 0
	if(left) xo = -3
	return getcell(x + 5 + xo, y + 4)
end

function getleftcell()
	local xo = 0
	if(left) xo = -1
	return getcell(x + 2 + xo, y+4)
end

function getrightcell()
	local xo = 0
	if(left) xo = -3
	return getcell(x + 6 + xo, y+4)
end

function getbottomcells()
	local cells = {}
	
	cells.a = getcell(x + 3, y + 8)
	cells.b = getcell(x + 5, y + 8)

	return cells
end

-- a local function to get the
-- map cell from world coordinates
function getcell(wx, wy)
	-- create a locally scoped table 
	-- to hold our result
	local cell = {}
	
	-- calculate the map cell
	cell.x = flr(wx / 8)
	cell.y = flr((wy - 28)/8)
	
	-- return the result
	return cell
end

-- returns true if the left edge
-- of the cell is solid
function hardleft(cell)
	-- grab the sprite id of 
	-- the map cell we're checking
	local cellid = mget(cell.x, cell.y)
	-- find out if 2nd flag is set
	return fget(cellid, 1)
end

-- returns true if the right edge
-- of the cell is solid
function hardright(cell)
	-- grab the sprite id of 
	-- the map cell we're checking
	local cellid = mget(cell.x, cell.y)
	-- find out if 3rd flag is set
	return fget(cellid, 2)
end

-- returns true if the top edge
-- of the cell is solid
function hardtop(cell)
	-- grab the sprite id of 
	-- the map cell we're checking
	local cellid = mget(cell.x, cell.y)
	-- find out if 1st flag is set
	return fget(cellid, 0)
end

-->8
-- demo switching

function loadnextdemo()
	load('scrolling.p8', 'previous demo')	
end
__gfx__
002d2200002d2200002d2200002d2200002d2200002d2200028d2200220000000000000000000000000000000000000000000000000000000000000000000000
00822400008224000082240000822400008224000882440028224400022800000000000000000000000000000000000000000000000000000000000000000000
008244000082440000824400008244000082440008224400222244000282d200028d2200002d2200000000000000000000000000000000000000000000000000
00229a0000229a0000229a0000229a0000229a0002229a4004429a00022244002822440000822400000000000000000000000000000000000000000000000000
00024a0000024a000004aa400042a40000024a000049aa000009aa40002244002222440000824400000000000000000000000000000000000000000000000000
00004a000000a4000009490000099a400000a400042aad00000aad0000049a4000029a4000229a40000000000000000000000000000000000000000000000000
0000d5000001d50000050d00000d05000001dd0000d01000000d01000040aad00004aaa000024a90000000000000000000000000000000000000000000000000
000011000000100000100100001001000000100001000000000010000000151000014a1000019410000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000777700000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000007777770077000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000077777677777707700000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000077777767777677770000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000067777767777767770000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000067777777677767760000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000006667777766777000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000066666677000000000000000000000000000000000000000000000000000000000000000000000
3b3b3b3b444444443b3b3b3b3b3b3b3b44444b3b3b34444400000000000000000000000000000000000000000000000000000000000000000000000000000000
b3b3b3b344444444b3b3b3b3b3b3b3b3444443b3b3b4444400000000000000000000000000000000000000000000000000000000000000000000000000000000
44344434444444443b34443444344b3b444444344434444400000000000000000000000000000000000000000000000000000000000000000000000000000000
4444444444444444b3b44444444444b3444444444444444400000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444443b44444444444b3b444444444444444400000000000000000000000000000000000000000000000000000000000000000000000000000000
4444444444444444b3b44444444444b3444444444444444400000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444443b44444444444b3b444444444444444400000000000000000000000000000000000000000000000000000000000000000000000000000000
4444444444444444b3b44444444444b3444444444444444400000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101030501010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000026270000000000002627000000000026270000000026270000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0026270000000000002627000000000026270000000000000000000026270000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000002627000000000026270000000000000026270000000000000026270000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000002627000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000262700000000002627000000002627000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000002627000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000002627000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000003233000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000323534330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3030303030303030353131343030303030303030303030303030303030303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3131313131313131313131313131313131313131313131313131313131313131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3131313131313131313131313131313131313131313131313131313131313131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3131313131313131313131313131313131313131313131313131313131313131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3131313131313131313131313131313131313131313131313131313131313131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3131313131313131313131313131313131313131313131313131313131313131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3131313131313131313131313131313131313131313131313131313131313131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3131313131313131313131313131313131313131313131313131313131313131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3131313131313131313131313131313131313131313131313131313131313131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
