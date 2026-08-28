execute store result score #x gb run data get entity @s Pos[0]
execute store result score #z gb run data get entity @s Pos[2]

# snap to the grid lattice (floorDiv then multiply keeps negatives correct)
scoreboard players operation #x gb /= #three gb
scoreboard players operation #x gb *= #three gb
scoreboard players operation #z gb /= #three gb
scoreboard players operation #z gb *= #three gb

# walk back to the lower-left corner of the square
scoreboard players operation #off gb = #k gb
scoreboard players operation #off gb *= #three gb
scoreboard players operation #x gb -= #off gb
scoreboard players operation #z gb -= #off gb
scoreboard players operation #z0 gb = #z gb

# side length in grid points = 2k+1
scoreboard players operation #count gb = #k gb
scoreboard players operation #count gb *= #two gb
scoreboard players add #count gb 1
scoreboard players operation #cx gb = #count gb

execute store result storage gridblock:tmp args.x int 1 run scoreboard players get #x gb
execute store result storage gridblock:tmp args.y int 1 run scoreboard players get #gy gb
execute store result storage gridblock:tmp args.z int 1 run scoreboard players get #z gb
function gridblock:scan_begin with storage gridblock:tmp args
