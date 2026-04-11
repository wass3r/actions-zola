# Zola GitHub Action

Build static sites with [Zola](https://www.getzola.org/) in GitHub Actions with cryptographically verified binaries.

## Features

- **Secure by default**: All binaries verified via Sigstore attestation + SHA256 checksum
- **Cross-platform**: Linux, macOS, Windows (x86_64 and ARM)
- **Fast**: Automatic caching of verified binaries (using `actions/cache`)
- **Simple**: Minimal configuration required

## Quick Start

```yaml
name: Deploy site

on:
  push:
    branches: [main]

permissions:
  contents: read

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
        with:
          persist-credentials: false
      
      - uses: wass3r/actions-zola@v2
      
      - name: Deploy
        run: |
          # Your deployment logic
          # Built site is in ./public
```

> [!TIP]
> For a complete example of building _and_ deploying to GitHub Pages, see the [Full GitHub Pages Example](#full-github-pages-example) below.

> [!NOTE]
> It is highly recommended to pin `wass3r/actions-zola` action (and any GitHub Action) with digest [for security](https://docs.github.com/en/actions/reference/security/secure-use?learn=getting_started#using-third-party-actions).

## Inputs

| Input          | Description                               | Default        |
| -------------- | ----------------------------------------- | -------------- |
| `zola_version` | Zola version (v0.20.0+ required)          | `v0.22.1`      |
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

> [!NOTE]
> The `gh_token` input defaults to `github.token` and is used for:
> - Sigstore attestation verification via `gh` CLI
> - Fetching SHA256 checksums from GitHub API (for releases after June 202

### Legacy Versions

Need Zola < v0.20.0? Use v1 of this action:

```yaml
- uses: wass3r/actions-zola@v1
  with:
    zola_version: v0.22.1
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

### Full GitHub Pages Example

No extra token(s) needed. `wass3r/actions-zola` builds the site, `actions/upload-pages-artifact` uploads the built site as an artifact, and `actions/deploy-pages` deploys it to GitHub Pages from the artifact.

```yaml
name: Deploy site

on:
  push:
    branches: [main]

permissions:
  contents: read

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
        with:
          persist-credentials: false
      
      - uses: wass3r/actions-zola@v2
      
      - name: upload
        id: deployment
        uses: actions/upload-pages-artifact@v5
        with:
          path: public/

  deploy:
    needs: build
    runs-on: ubuntu-latest

    permissions:
      id-token: write
      pages: write

    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}

    steps:
      - name: deploy to pages
        id: deployment
        uses: actions/deploy-pages@v5
```

## License

MIT