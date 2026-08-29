tag @s add gb_init

# only rescue the very first spawn, which the world bakes at y=-63 below the grid
execute store result score #py gb run data get entity @s Pos[1]
scoreboard players operation #py gb -= #gy gb
execute if score #py gb matches ..-16 run tp @s 8 1 8
