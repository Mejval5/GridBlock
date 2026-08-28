execute if block ~ ~ ~ minecraft:air run function gridblock:place

scoreboard players add #z gb 3
scoreboard players remove #cz gb 1
execute if score #cz gb matches 1.. positioned ~ ~ ~3 run function gridblock:loop_z
