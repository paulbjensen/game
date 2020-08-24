dirt = love.graphics.newImage("dirt2.png")
grass = love.graphics.newImage("grass4.png")

function love.load()

	window_width = 800
	window_height = 600

	block_width = grass:getWidth()
	block_height = grass:getHeight()
	block_depth = block_height --/ 2 // No need - graphics are already isometric
	
	grid_size = 10
	
	-- Where the grid x,y coordinates the center
	grid_x = 360
	grid_y = 300

 
	grid = {}
	for x = 1,grid_size do
		grid[x] = {}
		for y = 1,grid_size do
			grid[x][y] = 1
		end
	end
	
	grid[2][4] = 2
	grid[6][5] = 2
	
end

function draw_tile(image, x, y)
	love.graphics.draw(image,
	grid_x + ((y-x) * (block_width / 2)),
	grid_y + ((x+y) * (block_depth / 2)) - (block_depth * (grid_size / 2)))
end

function love.draw()



	for x = 1,grid_size do
		for y = 1,grid_size do
			if grid[x][y] == 1 then
				draw_tile(grass, x, y)
			else -- grid[x][y] == 2
				draw_tile(dirt, x, y)
			end
		end
	end
end