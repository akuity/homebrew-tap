# Homebrew Tap for Kargo

Homebrew formula that allows installation of [Kargo](https://github.com/akuity/kargo) through the [Homebrew](https://brew.sh/) package manager.

## Installation

```bash
brew tap akuity/tap
brew install akuity/tap/kargo
```

## Uninstallation

```bash
brew uninstall akuity/tap/kargo
brew untap akuity/tap
```

## How to Update the Homebrew Tap

To update the Homebrew tap for a new release, use the `./update.sh` script with the following syntax:
```bash
./update.sh <binary-name> <version> [optional-versioned-formula]
```

### Examples

#### 1. Updating the main formula (no versioning):
If you're releasing a new version without version-specific formulas, run:
```bash
./update.sh kargo v1.0.0
```

#### 2. Updating a versioned formula:
For example, to create or update a versioned formula for `kargo` version 1.1, include the version suffix (`@<major.minor>`):
```bash
./update.sh kargo v1.1.0 @1.1
```

### Notes
- **`<version>`**: The version of the release, prefixed with `v` (e.g., `v1.0.0`).
- **`[optional-versioned-formula]`**: Used only if you're managing multiple versions of the binary (e.g., `@1.1` for version 1.1). If omitted, it updates the main formula.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh/) for further guidance.
