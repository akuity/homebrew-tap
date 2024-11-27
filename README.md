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

## How to Update the Tap

To update the tap for a new Kargo release

Clone the tap repository:
```bash
git clone https://github.com/akuity/homebrew-tap.git
cd homebrew-tap
```

Use the `update.sh` script to update the formula:
```bash
./update.sh kargo <VERSION>
```
Replace `<VERSION>` with the new Kargo version. For example: `./update.sh kargo v1.0.0`

Verify the updated formula:
```bash
brew install --build-from-source ./kargo.rb
```

Test the installation to ensure the correct version is installed:
```bash
kargo --version
```

Commit and push the changes:
```bash
git add kargo.rb
git commit -m "Update Kargo formula to version <VERSION>"
git push origin main
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh/) for further guidance.
