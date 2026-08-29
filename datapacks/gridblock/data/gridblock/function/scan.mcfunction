# walk a single line of blocks at fixed X, extending into +Z from the origin
execute store result score #z gb run data get entity @s Pos[2]

# snap player Z to the lattice, aligned to the origin so it works for any spacing
# (floorDiv then multiply keeps negatives correct)
scoreboard players operation #z gb -= #lz0 gb
scoreboard players operation #z gb /= #space gb
scoreboard players operation #z gb *= #space gb
scoreboard players operation #z gb += #lz0 gb

# start the window k steps behind the player
scoreboard players operation #off gb = #k gb
scoreboard players operation #off gb *= #space gb
scoreboard players operation #z gb -= #off gb

# the line only exists from its origin onward, so clamp the start there
execute if score #z gb < #lz0 gb run scoreboard players operation #z gb = #lz0 gb

# window length in points = 2k+1
scoreboard players operation #count gb = #k gb
scoreboard players operation #count gb *= #two gb
scoreboard players add #count gb 1
scoreboard players operation #cz gb = #count gb

# X is fixed to the line
scoreboard players operation #x gb = #lx gb

execute store result storage gridblock:tmp args.x int 1 run scoreboard players get #x gb
execute store result storage gridblock:tmp args.y int 1 run scoreboard players get #gy gb
execute store result storage gridblock:tmp args.z int 1 run scoreboard players get #z gb
execute store result storage gridblock:tmp args.step int 1 run scoreboard players get #space gb
function gridblock:line_begin with storage gridblock:tmp args
