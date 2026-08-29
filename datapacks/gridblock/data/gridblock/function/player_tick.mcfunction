# every tick: repair anything broken within reach
scoreboard players operation #k gb = #repair_k gb
function gridblock:scan

# a new world bakes its spawn at y=-63 (below the grid); the first time we ever
# see a player, if they're below the grid drop them onto the guaranteed spawn
# column (8,8) - a real lattice point - then tag them so building below y=0 later
# never triggers this again
execute unless entity @s[tag=gb_init] run function gridblock:init_player

# periodically: extend the grid into newly loaded area
execute if score #timer gb matches 0 run function gridblock:generate
