# Unity of Command 2 - All Divisions 7 Steps / 3 Specialists

Steam Workshop item:
https://steamcommunity.com/sharedfiles/filedetails/?id=3757182297

This Unity of Command 2 mod changes every base-game and DLC division unit type to:

- `max_st: 7`
- `max_spec: 3`

## Files

- `data/entity_types/unit_types/`: full unit type YAML overrides used by the game
- `rebuild_mod.ps1`: regenerates all override files from the installed game data
- `thumb.jpg`: Steam Workshop preview image

## Rebuild

Run this from the Unity of Command 2 install directory:

```powershell
powershell -ExecutionPolicy Bypass -File .\uoc2_all_divisions_7st_3spec\rebuild_mod.ps1
```

The script copies every original file from:

```text
_packages\base\data\entity_types\unit_types
```

Then it only changes or adds:

```yaml
max_st: 7
max_spec: 3
```

Full YAML files are required. Minimal files containing only `max_st` and `max_spec` fail game data validation.

## Upload Or Update Steam Workshop

The game uploader reads the package from:

```text
%LocalAppData%\.uoc2\_packages\uoc2_all_divisions_7st_3spec
```

If needed, sync the working copy there first:

```powershell
Copy-Item -Path ".\uoc2_all_divisions_7st_3spec\*" -Destination "$env:LocalAppData\.uoc2\_packages\uoc2_all_divisions_7st_3spec" -Recurse -Force
```

Then upload/update:

```powershell
.\prep.exe steam_ws_upload uoc2_all_divisions_7st_3spec --title "All Divisions 7 Steps 3 Specialists" --description "Sets all unit types to max_st 7 and max_spec 3 for base game and DLC divisions." --visibility 2
```

Use `--visibility 2` for hidden testing, then set the item public on Steam or upload again with the desired visibility.
