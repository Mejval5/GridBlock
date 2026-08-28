# rescue anyone who fell off the grid
execute store result score #py gb run data get entity @s Pos[1]
execute if score #py gb matches ..-40 run tp @s 0 2 0

# every tick: repair anything broken within reach
scoreboard players operation #k gb = #repair_k gb
function gridblock:scan

# periodically: extend the grid into newly loaded area
execute if score #timer gb matches 0 run function gridblock:generate
