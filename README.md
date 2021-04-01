# Zomboid Mod Release Notes

A small tool to show mod release notes on update.

## For Players
You can install `Mod Release Notes` like any other mod you use. Every time Zomboid starts (well, enters the Main Menu) the mod checks if a mod has been updated since the last check, and will show release notes if any are available.

## For Modders

Supporting Release Notes in your mod is easy. Just add a "releasenotes.ini" file with the following content:

```
[Version 0.2.0]
title=Code cleanup
description=No new features, but a lot of internal cleanup.

[Version 0.1.0]
title=Initial release
description=Initial release of this mod.
```

- ```[Version 0.1.0]``` This is a version tag, can be anything.
- ```title=``` The title of the release notes to be displayed.
- ```description=``` A description to be shown below the title.
