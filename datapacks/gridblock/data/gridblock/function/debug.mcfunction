say --- gridblock debug ---
scoreboard players get #n gb
scoreboard players get #salt gb
scoreboard players get #h gb
data get storage gridblock:blocks list[0]
data get storage gridblock:tmp args
execute store result score #probe gb run setblock 8 0 8 minecraft:diamond_block strict
scoreboard players get #probe gb
