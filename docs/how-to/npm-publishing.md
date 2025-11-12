# NPM Publishing Guide

This document explains how automated NPM publishing works in this monorepo.

## Overview

The monorepo contains 8 packages, of which 7 are published to NPM:

| Package | NPM Name | Published |
|---------|----------|-----------|
| core | `@noraeb/core` | ✅ |
| openscd | `@noraeb/open-scd` | ✅ |
| xml | `@noraeb/xml` | ✅ |
| forms | `@noraeb/forms` | ✅ |
| wizards | `@noraeb/wizards` | ✅ |
| addons | `@noraeb/addons` | ✅ |
| plugins | `@noraeb/plugins` | ✅ |
| distribution | `@noraeb/distribution` | ❌ (private) |

## Setup

### 1. Generate NPM Token

1. Log in to [npmjs.com](https://www.npmjs.com)
2. Go to Account Settings → Access Tokens
3. Click "Generate New Token" → "Classic Token"
4. Select "Automation" type (for CI/CD publishing)
5. Copy the generated token

### 2. Add Token to GitHub Secrets

1. Go to your GitHub repository settings
2. Navigate to: Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Name: `NPM_TOKEN`
5. Value: Paste your NPM token
6. Click "Add secret"

### 3. Ensure NPM Organization Access

Make sure you have publish access to the `@noraeb` NPM organization. If not:
- Ask the organization owner to add you as a member with publish permissions
- Or update all `package.json` files to use a different scope you have access to

## How It Works

### Release Process

1. **Commit your changes** using [Conventional Commits](https://www.conventionalcommits.org/):
   ```bash
   git commit -m "feat: add new feature"
   git commit -m "fix: resolve bug"
   ```

2. **Push to main branch**:
   ```bash
   git push origin main
   ```

3. **Release Please creates PR**: 
   - Automatically creates/updates a "Release PR" with changelogs
   - Version numbers are bumped based on conventional commits

4. **Merge the Release PR**:
   - Review the changelog and version bumps
   - Merge the PR to trigger the release

5. **Automated Publishing**:
   - GitHub Actions workflow runs automatically
   - Builds all packages (`npm run build`)
   - Publishes each package to NPM
   - Creates GitHub release with build artifacts (zip/tar.gz)

### Publishing Order

Packages are published in dependency order to ensure dependencies are available:

1. `@noraeb/core` (base dependency)
2. `@noraeb/xml`
3. `@noraeb/forms`
4. `@noraeb/wizards` (depends on core)
5. `@noraeb/addons` (depends on core)
6. `@noraeb/plugins`
7. `@noraeb/open-scd` (main package)

### Error Handling

- Each package publish step uses `continue-on-error: true`
- If a package version already exists on NPM, it won't fail the workflow
- Other packages will still be published even if one fails

## Manual Publishing (if needed)

If you need to publish a single package manually:

```bash
# Build the package
npm run build

# Navigate to the package
cd packages/core  # or any other package

# Publish
npm publish --access public
```

## Troubleshooting

### "You do not have permission to publish"

**Solution**: Ensure you're logged into NPM with an account that has access to the `@noraeb` organization:
```bash
npm login
```

### "Cannot publish over existing version"

**Solution**: The version already exists on NPM. Update the version in `package.json` or let release-please handle versioning.

### "Invalid token"

**Solution**: 
1. Regenerate the NPM token
2. Update the `NPM_TOKEN` secret in GitHub repository settings

### Package not publishing

**Solution**: 
1. Check the GitHub Actions logs for specific errors
2. Ensure the package has `publishConfig.access: "public"` in its `package.json`
3. Verify the package has a build output (check `files` field in `package.json`)

## Configuration Files

- **`.github/workflows/release-please.yml`**: GitHub Actions workflow for automated publishing
- **`release-please-config.json`**: Release Please configuration for versioning
- **`packages/*/package.json`**: Individual package configurations

## Best Practices

1. **Use Conventional Commits**: Ensures proper version bumping
   - `feat:` → minor version bump (0.1.0 → 0.2.0)
   - `fix:` → patch version bump (0.1.0 → 0.1.1)
   - `feat!:` or `BREAKING CHANGE:` → major version bump (0.1.0 → 1.0.0)

2. **Test before merging**: Run `npm test` and `npm run build` locally

3. **Review Release PR carefully**: Check all version bumps and changelogs

4. **Keep dependencies in sync**: When updating `@noraeb/*` dependencies in packages, ensure versions are compatible

## Additional Resources

- [Release Please Documentation](https://github.com/googleapis/release-please)
- [Conventional Commits Specification](https://www.conventionalcommits.org/)
- [NPM Publishing Documentation](https://docs.npmjs.com/cli/v9/commands/npm-publish)
