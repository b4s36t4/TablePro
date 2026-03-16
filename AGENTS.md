# AGENTS.md

## Cursor Cloud specific instructions

### Platform constraints

TablePro is a **macOS-only native app** (SwiftUI + AppKit). The Cloud Agent VM runs Linux, so `xcodebuild` (build, test, run) is unavailable. The tools that **do** work on the Linux VM:

| Tool | Command | Notes |
|---|---|---|
| **SwiftLint** | `swiftlint lint --strict` | Static binary; lints 367 files in `TablePro/` per `.swiftlint.yml` |
| **SwiftFormat** | `swiftformat --lint .` | See known issue below |

### Known issues

- **SwiftFormat config typo**: `.swiftformat` contains `--ifdefindent no-indent` but the correct option name is `--ifdef`. SwiftFormat will fail with `Unknown option --ifdefindent`. This is a pre-existing repo issue, not a Cloud Agent environment problem.

### What you can do

- **Lint**: `swiftlint lint --strict` (runs successfully, exit 0 = clean)
- **Format check**: `swiftformat --lint .` (blocked by the config typo above)
- **Read/edit Swift source**: all source files under `TablePro/`, `Plugins/`, `TableProTests/`, `LocalPackages/`

### What you cannot do on this VM

- **Build** (`xcodebuild build`) — requires Xcode on macOS
- **Run tests** (`xcodebuild test`) — requires Xcode on macOS
- **Run the app** — `.app` bundles are macOS-only
- **Download static libraries** (`scripts/download-libs.sh`) — downloads macOS `.a` files, not useful on Linux

### References

- Build/test/lint commands: see `CLAUDE.md` and `CONTRIBUTING.md` at the repo root
- CI workflow: `.github/workflows/build.yml` (runs on `macos-15` GitHub Actions runners)
- Project architecture and code style: `CLAUDE.md`
