scoreboard players add #timer gb 1
execute if score #timer gb >= #gen_period gb run scoreboard players set #timer gb 0

execute as @a at @s run function gridblock:player_tick
