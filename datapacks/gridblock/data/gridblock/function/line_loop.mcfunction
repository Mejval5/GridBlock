execute if block ~ ~ ~ minecraft:air run function gridblock:place

scoreboard players add #z gb 2
scoreboard players remove #cz gb 1
execute if score #cz gb matches 1.. positioned ~ ~ ~2 run function gridblock:line_loop
