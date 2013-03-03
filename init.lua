minetest.register_tool("mapp:map", {
	description = "map",
	inventory_image = "map_block.png",
	on_use = function(itemstack, user, pointed_thing)
	map_handler(itemstack,user,pointed_thing)
	end,
})
function map_handler (itemstack, user, pointed_thing)
		local pos = user:getpos()
		local player_name=user:get_player_name()
		local mapar = {}
		local map = ""
		local p = 0
		local po = {x = 0, y = 0, z = 0}
		local no = minetest.env:get_node(po)
		local node = ""
		local tile = ""
		local def = {}
		local tiles = {}
		local point = ""
		local yaw = math.pi/2
		local rotate = 0		
		pos.y = pos.y + 1
        yaw = user:get_look_yaw()
        if yaw ~= nil then
           yaw = math.deg(yaw)
           yaw = math.fmod (yaw, 360)
           if yaw<0 then yaw = 360 - yaw end
           if yaw>360 then yaw = yaw - 360 end
           minetest.chat_send_all(yaw)           
           if      yaw<= 5 then yaw =  0 rotate = 90
           elseif yaw<= 15 then yaw = 10 rotate = 90           
           elseif yaw<= 25 then yaw = 20 rotate = 90
           elseif yaw<= 35 then yaw = 30 rotate = 90
           elseif yaw<= 45 then yaw = 40 rotate = 90
           elseif yaw<= 55 then yaw = 50 rotate = 90
           elseif yaw<= 65 then yaw = 60 rotate = 90
           elseif yaw<= 75 then yaw = 70 rotate = 90
           elseif yaw<= 85 then yaw = 80 rotate = 90
           elseif yaw<= 95 then yaw = 0  rotate = 180 
           elseif yaw<=105 then yaw = 10 rotate = 180  
           elseif yaw<=115 then yaw = 20 rotate = 180 
           elseif yaw<=125 then yaw = 30 rotate = 180 
           elseif yaw<=135 then yaw = 40 rotate = 180 
           elseif yaw<=145 then yaw = 50 rotate = 180 
           elseif yaw<=155 then yaw = 60 rotate = 180 
           elseif yaw<=165 then yaw = 70 rotate = 180 
           elseif yaw<=175 then yaw = 80 rotate = 180 
           elseif yaw<=185 then yaw =  0 rotate = 270 
           elseif yaw<=195 then yaw = 10 rotate = 270 
           elseif yaw<=205 then yaw = 20 rotate = 270 
           elseif yaw<=215 then yaw = 30 rotate = 270 
           elseif yaw<=225 then yaw = 40 rotate = 270 
           elseif yaw<=235 then yaw = 50 rotate = 270 
           elseif yaw<=245 then yaw = 60 rotate = 270 
           elseif yaw<=255 then yaw = 70 rotate = 270 
           elseif yaw<=265 then yaw = 80 rotate = 270 
           elseif yaw<=275 then yaw =  0 rotate = 0
           elseif yaw<=285 then yaw = 10 rotate = 0
           elseif yaw<=295 then yaw = 20 rotate = 0
           elseif yaw<=305 then yaw = 30 rotate = 0
           elseif yaw<=315 then yaw = 40 rotate = 0
           elseif yaw<=325 then yaw = 50 rotate = 0
           elseif yaw<=335 then yaw = 60 rotate = 0
           elseif yaw<=245 then yaw = 70 rotate = 0
           elseif yaw<=355 then yaw = 80 rotate = 0
           elseif yaw<=365 then yaw =  0 rotate = 90
           end           
        end		

		for i = -17,17,1 do
			mapar[i+17] = {}
			for j = -17,17,1 do
				mapar[i+17][j+17] = {}
				po = {x = pos.x+i, y = pos.y, z = pos.z+j}
				no = minetest.env:get_node(po)
				local k=po.y
				if no.name == "air" then
					while no.name == "air" do
						k=k-1
						po = {x = pos.x+i, y = k, z = pos.z+j}
						no = minetest.env:get_node(po)
					end
				elseif no.name ~= "air" and (no.name ~= "ignore")  then
						while (no.name ~= "air") and (no.name ~= "ignore") do
							k=k+1
							po = {x = pos.x+i, y = k, z = pos.z+j}
							no = minetest.env:get_node(po)
						end
				  k=k-1
				  po = {x = pos.x+i, y = k, z = pos.z+j}
				end

				node = minetest.env:get_node(po)
				tile = ""
				def = minetest.registered_nodes[node.name]				
				if def then tiles = def["tiles"] end
				if tiles ~=nil then
					tile = tiles[1]  
				end

				if type(tile)=="table" then 
				  tile=tile["name"] 
				end
				mapar[i+17][j+17].y = k
				mapar[i+17][j+17].im = tile
			end
		end

	for i=1,32,1 do
		for j=1,32,1 do
			if mapar[i][j].y ~= mapar[i][j+1].y then mapar[i][j].im = mapar[i][j].im .. "^1black_blockt.png" end
			if mapar[i][j].y ~= mapar[i][j-1].y then mapar[i][j].im = mapar[i][j].im .. "^1black_blockb.png" end
			if mapar[i][j].y ~= mapar[i-1][j].y then mapar[i][j].im = mapar[i][j].im .. "^1black_blockl.png" end
			if mapar[i][j].y ~= mapar[i+1][j].y then mapar[i][j].im = mapar[i][j].im .. "^1black_blockr.png" end
			point = "image[".. 0.15*(i) ..",".. 0.15*(32-j)+0.1 ..";0.2,0.2;" .. mapar[i][j].im .. "]"
			map = map .. point
		end
	end
	
   if rotate ~= 0 then	
   point = 	"image[".. 0.15*(16)+0.075 ..",".. 0.15*(16)-0.085 ..";0.4,0.4;d" .. yaw .. ".png^[transformFYR".. rotate .."]"
   else
   point = 	"image[".. 0.15*(16)+0.075 ..",".. 0.15*(16)-0.085 ..";0.4,0.4;d" .. yaw .. ".png^[transformFY]"   
   end
   map = map .. point   
   minetest.show_formspec(player_name, "mapp:map", "size[5.2,5]"..map)
end
