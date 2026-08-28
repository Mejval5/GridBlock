# deterministic per-column hash of (#x, #z) -> #h in [0, #n)
# constants are sized so no intermediate ever exceeds 2^31-1
scoreboard players operation #h gb = #x gb
scoreboard players operation #h gb %= #hm gb
scoreboard players operation #t gb = #z gb
scoreboard players operation #t gb %= #hm gb
scoreboard players operation #h gb *= #hm gb
scoreboard players operation #h gb += #t gb

scoreboard players operation #h gb %= #hp gb
scoreboard players operation #h gb *= #hk1 gb
scoreboard players add #h gb 12345
scoreboard players operation #h gb %= #hp gb
scoreboard players operation #h gb *= #hk2 gb
scoreboard players add #h gb 6789
scoreboard players operation #h gb %= #hp gb

scoreboard players operation #h gb %= #n gb
function gridblock:dispatch
