# deterministic per-column hash of (#x, #z) -> #h in [0, #n)
# constants are sized so no intermediate ever exceeds 2^31-1
# the spawn column (8,8) is always grass so there is solid footing to respawn on
execute if score #x gb matches 8 if score #z gb matches 8 run return run setblock ~ ~ ~ minecraft:grass_block strict
scoreboard players operation #h gb = #x gb
scoreboard players operation #h gb %= #hm gb
scoreboard players operation #t gb = #z gb
scoreboard players operation #t gb %= #hm gb
scoreboard players operation #h gb *= #hm gb
scoreboard players operation #h gb += #t gb

scoreboard players operation #h gb %= #hp gb
scoreboard players operation #h gb += #salt gb
scoreboard players operation #h gb %= #hp gb
scoreboard players operation #h gb *= #hk1 gb
scoreboard players add #h gb 12345
scoreboard players operation #h gb %= #hp gb
scoreboard players operation #h gb *= #hk2 gb
scoreboard players add #h gb 6789
scoreboard players operation #h gb %= #hp gb

scoreboard players operation #h gb %= #n gb
execute store result storage gridblock:tmp args.i int 1 run scoreboard players get #h gb
function gridblock:pick with storage gridblock:tmp args
function gridblock:set with storage gridblock:tmp args
