# --- config ---------------------------------------------------------------
scoreboard objectives add gb dummy

# Y level of the line (0 leaves the whole world below it free to build in)
scoreboard players set #gy gb 0
# the line runs at a fixed X, starting at this Z and extending into +Z
scoreboard players set #lx gb 8
scoreboard players set #lz0 gb 8
# repair pass half-size, in steps (4 => +/-8 blocks, covers creative reach)
scoreboard players set #repair_k gb 4
# generation pass half-size, in steps (32 => +/-64 blocks ahead/behind)
scoreboard players set #gen_k gb 32
# ticks between generation passes
scoreboard players set #gen_period gb 10
# --------------------------------------------------------------------------

# spacing = 2 (1 block, 1 air)
scoreboard players set #space gb 2
scoreboard players set #two gb 2

# /random seeds its sequences from the world seed; rolled once, then persisted
# in the scoreboard so the layout stays fixed for the lifetime of the world
execute unless score #salt gb matches -2147483648.. store result score #salt gb run random value 0..1000000 gridblock:salt

# hash constants, chosen so no intermediate exceeds 2^31-1
scoreboard players set #hm gb 46337
scoreboard players set #hp gb 1000003
scoreboard players set #hk1 gb 2039
scoreboard players set #hk2 gb 1531

scoreboard players set #timer gb 0

# a full generation pass is a few tens of thousands of commands
gamerule max_command_sequence_length 1000000
gamerule respawn_radius 0
setworldspawn 8 1 8

function gridblock:palette
execute store result score #n gb run data get storage gridblock:blocks list

# make sure the spawn block exists before anyone lands on it
scoreboard players set #x gb 8
scoreboard players set #z gb 8
execute positioned 8.0 0.0 8.0 run function gridblock:place
