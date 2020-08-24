-- https://github.com/davidm/lua-matrix/blob/master/lua/matrix.lua
local matrix = require 'matrix'

-- Origin x,y (Screen coord)
Ix0, Iy0 = 93, 329; -- Isometric
Dx0, Dy0 = 450, 329; -- Descartes

-- invert y axis, move to Dx0, Dy0
descartesToScreenMatrix = (matrix{{1, 0, Dx0}, {0, 1, Dy0}, {0, 0, 1}} * matrix{{1, 0, 0}, {0, -1, 0}, {0, 0, 1}})
-- Basis Vector I is (sqrt(3)/2, -1/2), J is (0, 1)
descartesToIsometricMatrix = matrix{{0.86602, 0, 0}, {-0.5, 1, 0}, {0, 0, 1}};
-- invert D to I
isometricToDescartesMatrix = matrix.invert(descartesToIsometricMatrix);
-- invert y axis, move to Ix0, Iy0
isometricToScreenMatrix = (matrix{{1, 0, Ix0}, {0, 1, Iy0}, {0, 0, 1}} * matrix{{1, 0, 0}, {0, -1, 0}, {0, 0, 1}})

-- Player is in the ISOMETRIC coord.
playerX = 0;
playerY = 0;

-- screen coords.
descartesScreenX, descartesScreenY = 0,0;
isometircScreenX, isometricScreenY = 0,0;

-- transformed player position (in descartes)
desPosX, desPosY = 0,0;

function love.init()
	-- nothing to do.
end

function love.update()

	local amt = 1;

	-- move player's coord (screen coord sys)

	if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
		playerX = playerX - amt;
	end
	if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		playerX = playerX + amt;
	end
	if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
		playerY = playerY + amt;
	end
	if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
		playerY = playerY - amt;
	end

	isometircScreenX, isometricScreenY 	= IsometricToScreenCoordinate(playerX, playerY);
	desPosX, desPosY 					= IsometricToDescartesCoordinate(playerX, playerY);
	descartesScreenX, descartesScreenY 	= DescartesToScreenCoordinate(desPosX, desPosY);

end

function love.draw()

	love.graphics.setColor(255, 255, 255, 255);

	-- info
	love.graphics.print("[Use WASD or Arrow keys to move, you're moving player in isometric]", 0, 0);
	love.graphics.print("Descartes player Position "..math.floor(desPosX).." , "..math.floor(desPosY), 0, 30);
	love.graphics.print("Player is on Tile ("..math.floor(desPosX/20).." , "..math.floor(desPosY/20)..")", 0, 60);

	-- display 'descartes'
	love.graphics.print("DESCARTES", descartesScreenX, descartesScreenY);

	-- display 'isometric'
	love.graphics.print("ISOMETRIC", isometircScreenX, isometricScreenY);

	-- draw graphs
	DrawGraph("<Transformed>", DescartesToScreenCoordinate);
	DrawGraph("<Game Map>", DescartesToIsometricScreenCoordinate);

end

function DrawGraph(title, transfromFunction)

	drawLine = function(x0, y0, x1, y1)
		local xBegin, yBegin = transfromFunction(x0, y0);
		local xEnd, yEnd = transfromFunction(x1, y1);
		love.graphics.line(xBegin, yBegin, xEnd, yEnd);
	end

	local x,y = 0,0;

	x2,y2 = transfromFunction(x,y + 220);
	love.graphics.print(title, x2, y2);

	drawLine(x, y, x, y + 200);
	drawLine(x, y, x + 200, y);

	love.graphics.setColor(255, 255, 255, 128);

	for i = 0, 10 do
		drawLine(x + i * 20, y, x + i * 20, y+200) -- y
	end

	for i = 0, 10 do
		drawLine(x, y + i * 20, x+200, y + i * 20) -- x
	end
	
	love.graphics.setColor(255, 255, 255, 255);

end

-- matrix * vector (transform) functions

function DescartesToScreenCoordinate(x, y)
	descartesPosition = matrix{{x}, {y}, {1}};
	screenPosition = descartesToScreenMatrix * descartesPosition;

	return screenPosition[1][1], screenPosition[2][1];
end

function DescartesToIsometricCoordinate(x, y)
	descartesPosition = matrix{{x}, {y}, {1}};
	isometricPosition = descartesToIsometricMatrix * descartesPosition;

	return isometricPosition[1][1], isometricPosition[2][1];
end

function IsometricToDescartesCoordinate(x, y)
	isometricPosition = matrix{{x}, {y}, {1}};
	descartesPosition = isometricToDescartesMatrix * isometricPosition;

	return descartesPosition[1][1], descartesPosition[2][1];
end

function IsometricToScreenCoordinate(x, y)
	isometricPosition = matrix{{x}, {y}, {1}};
	screenPosition = isometricToScreenMatrix * isometricPosition;

	return screenPosition[1][1], screenPosition[2][1];
end

-- only for isometric graph drawing
function DescartesToIsometricScreenCoordinate(x, y)
	isometricPosition = matrix{{x}, {y}, {1}};
	screenPosition = isometricToScreenMatrix * descartesToIsometricMatrix * isometricPosition;

	return screenPosition[1][1], screenPosition[2][1];
end