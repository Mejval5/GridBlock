scoreboard players operation #z gb = #z0 gb
scoreboard players operation #cz gb = #count gb
function gridblock:loop_z

scoreboard players add #x gb 3
scoreboard players remove #cx gb 1
execute if score #cx gb matches 1.. positioned ~3 ~ ~ run function gridblock:loop_x
