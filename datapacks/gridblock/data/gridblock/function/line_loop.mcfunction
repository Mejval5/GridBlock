execute if block ~ ~ ~ minecraft:air run function gridblock:place

scoreboard players operation #z gb += #space gb
scoreboard players remove #cz gb 1
$execute if score #cz gb matches 1.. positioned ~ ~ ~$(step) run function gridblock:line_loop with storage gridblock:tmp args
