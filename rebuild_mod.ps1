param(
    [string]$GameRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"

$sourceDir = Join-Path $GameRoot "_packages\base\data\entity_types\unit_types"
$modRoot = $PSScriptRoot
$targetDir = Join-Path $modRoot "data\entity_types\unit_types"

if (-not (Test-Path $sourceDir)) {
    throw "Source directory not found: $sourceDir"
}

New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

Get-ChildItem -Path $targetDir -File -Filter "*.yml" | Remove-Item -Force

$unitFiles = Get-ChildItem -Path $sourceDir -File -Filter "*.yml" | Sort-Object Name

foreach ($file in $unitFiles) {
    $content = Get-Content -Path $file.FullName

    $hasMaxSt = $false
    $hasMaxSpec = $false

    $content = foreach ($line in $content) {
        if ($line -match "^\s*max_st\s*:") {
            $hasMaxSt = $true
            "max_st: 7"
        }
        elseif ($line -match "^\s*max_spec\s*:") {
            $hasMaxSpec = $true
            "max_spec: 3"
        }
        else {
            $line
        }
    }

    if (-not $hasMaxSt) {
        $content += "max_st: 7"
    }

    if (-not $hasMaxSpec) {
        $content += "max_spec: 3"
    }

    $content += ""

    $targetPath = Join-Path $targetDir $file.Name
    Set-Content -Path $targetPath -Value $content -Encoding utf8
}

Write-Host ("Generated {0} unit override files in {1}" -f $unitFiles.Count, $targetDir)
