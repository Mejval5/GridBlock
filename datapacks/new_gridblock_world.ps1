#requires -Version 5.1
<#
Creates (or resets) a ready-to-play GridBlock world without going through the
Create World screen: void generator, cheats on, data pack already enabled.

    .\new_gridblock_world.ps1                # reset the "GridBlock" world
    .\new_gridblock_world.ps1 -NewSeed       # ...and roll a new world seed
    .\new_gridblock_world.ps1 -Name Test2    # use a different world folder

Run build_gridblock.ps1 first if the pack itself changed.

A template is snapshotted from an existing world the first time this runs;
26.x keeps world gen settings in data\minecraft\world_gen_settings.dat rather
than level.dat, so both files are needed.
#>
param(
    [string]$Name = 'GridBlock',
    [string]$Template = 'New World (11)',
    [switch]$NewSeed
)

$ErrorActionPreference = 'Stop'

$mc = Join-Path $env:APPDATA '.minecraft'
$saves = Join-Path $mc 'saves'
$tpl = Join-Path $mc 'datapacks\gridblock_template'
$zip = Join-Path $mc 'datapacks\gridblock.zip'
$genRel = 'data\minecraft\world_gen_settings.dat'

if (-not (Test-Path $zip)) { throw "Pack zip missing - run build_gridblock.ps1 first." }

# --- snapshot a template on first use -------------------------------------
if (-not (Test-Path $tpl)) {
    $src = Join-Path $saves $Template
    if (-not (Test-Path $src)) { throw "Template world '$Template' not found. Pass -Template '<world folder>'." }

    New-Item -ItemType Directory -Path (Join-Path $tpl 'data\minecraft') -Force | Out-Null
    Copy-Item (Join-Path $src 'level.dat') (Join-Path $tpl 'level.dat')
    Copy-Item (Join-Path $src $genRel) (Join-Path $tpl $genRel)
    "template captured from '$Template'"
}

# --- gzip helpers ----------------------------------------------------------
function Read-Gz([string]$path) {
    $in = [System.IO.File]::OpenRead($path)
    $ms = New-Object System.IO.MemoryStream
    try {
        $gz = New-Object System.IO.Compression.GZipStream($in, [System.IO.Compression.CompressionMode]::Decompress)
        $gz.CopyTo($ms); $gz.Dispose()
    }
    finally { $in.Dispose() }
    $ms.ToArray()
}

function Write-Gz([string]$path, [byte[]]$bytes) {
    $out = [System.IO.File]::Create($path)
    try {
        $gz = New-Object System.IO.Compression.GZipStream($out, [System.IO.Compression.CompressionMode]::Compress)
        $gz.Write($bytes, 0, $bytes.Length)
        $gz.Dispose()
    }
    finally { $out.Dispose() }
}

function Find-Name([byte[]]$b, [string]$name) {
    $needle = [System.Text.Encoding]::ASCII.GetBytes($name)
    for ($i = 0; $i -le $b.Length - $needle.Length; $i++) {
        $hit = $true
        for ($j = 0; $j -lt $needle.Length; $j++) {
            if ($b[$i + $j] -ne $needle[$j]) { $hit = $false; break }
        }
        if ($hit) { return $i }
    }
    -1
}

# --- rebuild the world -----------------------------------------------------
$dst = Join-Path $saves $Name
if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }

New-Item -ItemType Directory -Path (Join-Path $dst 'data\minecraft') -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $dst 'datapacks') -Force | Out-Null

Copy-Item (Join-Path $tpl $genRel) (Join-Path $dst $genRel)
Copy-Item $zip (Join-Path $dst 'datapacks\gridblock.zip')

# force cheats on: TAG_Byte payload sits directly after the tag name
$level = Read-Gz (Join-Path $tpl 'level.dat')
$i = Find-Name $level 'allowCommands'
if ($i -ge 0) { $level[$i + 'allowCommands'.Length] = 1 }
Write-Gz (Join-Path $dst 'level.dat') $level

if ($NewSeed) {
    $gen = Read-Gz (Join-Path $dst $genRel)
    $i = Find-Name $gen 'seed'
    if ($i -lt 0) { throw 'seed tag not found in world_gen_settings.dat' }
    $rng = New-Object Random
    $seed = New-Object byte[] 8
    $rng.NextBytes($seed)
    [Array]::Copy($seed, 0, $gen, $i + 4, 8)
    Write-Gz (Join-Path $dst $genRel) $gen
    "new seed rolled"
}

"world ready: $Name  (cheats on, gridblock enabled)"
