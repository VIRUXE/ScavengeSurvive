# test-boilerplate.inc

Package for testing non-gamemode modules, contains minimal code for spawning at Area 69.

## Usage

Simply install as a development dependency:

```bash
sampctl package install --dev ScavengeSurvive/test-boilerplate
```

This will ensure test-boilerplate is not included as a direct dependency for using your library.

Then include it into your library's test script:

```pawn
#include "your-library.inc"

#include <test-boilerplate>
```

Build and run your package:

```bash
sampctl package run --forceBuild
```

Connect to `localhost:7777` and test your library!

## Tips

The player spawn point is:

```text
300.0, 1800.0, 18.0
```

So place any in-world things you want to test/demo quickly nearby that location (not not on it as that could glitch the spawn).

Here are some pre-made coordinates in order of distance from the spawn for quick testing:

```text
302.0, 1800.0, 18.0
302.0, 1801.0, 18.0
302.0, 1802.0, 18.0
302.0, 1803.0, 18.0
302.0, 1804.0, 18.0
302.0, 1805.0, 18.0
302.0, 1806.0, 18.0
302.0, 1807.0, 18.0
302.0, 1808.0, 18.0
302.0, 1809.0, 18.0
```

The air field has the following coordinates:

```text
// Bottom-left corner (South-West)
297.0, 1794.0, 16.65

// Bottom-right corner (South-East)
320.0, 1794.0, 16.65

// Top-left corner (North-West)
297.0, 2058.0, 16.65

// Top-right corner (North-East)
320.0, 2058.0, 16.65
```

So if you're testing an in-world entity such as an item, create it anywhere in those boundaries for an easy, flat, open testing ground.
