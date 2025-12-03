# Zola GitHub Action

Build static sites with [Zola](https://www.getzola.org/) in GitHub Actions with cryptographically verified binaries.

## Features

- **Secure by default**: All binaries verified via Sigstore attestation + SHA256 checksum
- **Cross-platform**: Linux, macOS, Windows (x86_64 and ARM)
- **Fast**: Automatic caching of verified binaries
- **Simple**: Minimal configuration required

## Quick Start

```yaml
name: Deploy site

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          persist-credentials: false
      
      - uses: wass3r/actions-zola@v2
        with:
          zola_version: v0.21.0
      
      - name: Deploy
        run: |
          # Your deployment logic
          # Built site is in ./public
```

> [!NOTE]
> Highly recommended to pin your actions-zola action and any action with digest for security.

## Inputs

| Input          | Description                               | Default        |
| -------------- | ----------------------------------------- | -------------- |
| `zola_version` | Zola version (v0.20.0+ required)          | `v0.21.0`      |
| `root`         | Root directory for Zola project           | `.`            |
| `base_url`     | Override base URL from config.toml        |                |
| `output_dir`   | Output directory for built site           |                |
| `drafts`       | Include draft content                     | `false`        |
| `gh_token`     | GitHub token for attestation verification | `github.token` |

## Security

This action enforces the following security verification:

1. **Sigstore Attestation**: Cryptographically proves the binary was built by Zola's official CI from legitimate source code
2. **SHA256 Checksum**: Verifies file integrity

### Requirements

- **Zola v0.20.0 or later**: Required for attestation support
- **GitHub CLI (`gh`)**: Pre-installed on all GitHub-hosted runners
- **GitHub Token**: Automatically provided via `github.token` (can be overridden with `gh_token` input)

For self-hosted runners, [install the GitHub CLI](https://github.com/cli/cli#installation).

> **Note**: The `gh_token` input defaults to `github.token` and is used for:
> - Sigstore attestation verification via `gh` CLI
> - Fetching SHA256 checksums from GitHub API (for releases after June 2025)

### Legacy Versions

Need Zola < v0.20.0? Use v1 of this action:

```yaml
- uses: wass3r/actions-zola@v1
  with:
    zola_version: v0.18.0
```

## Examples

### Custom Directory Structure

```yaml
- uses: wass3r/actions-zola@v2
  with:
    root: ./docs
    output_dir: ./dist
    base_url: https://example.com
```

### Include Drafts

```yaml
- uses: wass3r/actions-zola@v2
  with:
    drafts: true
```

### Specific Version

```yaml
- uses: wass3r/actions-zola@v2
  with:
    zola_version: v0.20.0
```

## License

MIT