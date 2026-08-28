# --- config ---------------------------------------------------------------
scoreboard objectives add gb dummy

# Y level of the grid plane
scoreboard players set #gy gb 0
# number of distinct blocks in dispatch.mcfunction
scoreboard players set #n gb 16
# repair pass half-size, in grid steps (2 => 5x5 points => +/-6 blocks, covers reach)
scoreboard players set #repair_k gb 2
# generation pass half-size, in grid steps (12 => 25x25 points => +/-36 blocks)
scoreboard players set #gen_k gb 12
# ticks between generation passes
scoreboard players set #gen_period gb 10
# --------------------------------------------------------------------------

# grid spacing = 3 (1 block, 2 air)
scoreboard players set #three gb 3
scoreboard players set #two gb 2

# hash constants, chosen so no intermediate exceeds 2^31-1
scoreboard players set #hm gb 46337
scoreboard players set #hp gb 1000003
scoreboard players set #hk1 gb 2039
scoreboard players set #hk2 gb 1531

scoreboard players set #timer gb 0

# a full generation pass is a few tens of thousands of commands
gamerule maxCommandChainLength 1000000
gamerule spawnRadius 0
setworldspawn 0 1 0

# make sure the spawn block exists before anyone lands on it
scoreboard players set #x gb 0
scoreboard players set #z gb 0
execute positioned 0.0 0.0 0.0 run function gridblock:place
