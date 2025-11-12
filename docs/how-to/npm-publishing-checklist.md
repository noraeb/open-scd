# NPM Publishing Setup Checklist

Use this checklist to ensure NPM publishing is properly configured.

## Initial Setup (One-time)

- [ ] **Generate NPM Token**
  - Go to [npmjs.com](https://www.npmjs.com) → Account Settings → Access Tokens
  - Generate "Automation" token
  - Save the token securely

- [ ] **Add GitHub Secret**
  - Go to GitHub repository → Settings → Secrets and variables → Actions
  - Add secret named `NPM_TOKEN`
  - Paste your NPM token as the value

- [ ] **Verify NPM Organization Access**
  - Confirm you have publish permissions to `@noraeb` organization
  - Test with: `npm access ls-packages @noraeb`

- [ ] **Test Local Publishing (Optional)**
  - Run `npm run build` to ensure all packages build successfully
  - Try dry-run: `cd packages/core && npm publish --dry-run --access public`

## Package Configuration Verification

Verify each package has proper configuration:

### Core (`packages/core/package.json`)
- [x] `"name": "@noraeb/core"`
- [x] `"publishConfig": { "access": "public" }`
- [x] `"files"` field defined
- [x] Build outputs to correct location

### OpenSCD (`packages/openscd/package.json`)
- [x] `"name": "@noraeb/open-scd"`
- [x] `"publishConfig": { "access": "public" }`
- [x] `"files"` field defined

### XML (`packages/xml/package.json`)
- [x] `"name": "@noraeb/xml"`
- [x] `"publishConfig": { "access": "public" }`
- [x] `"files"` field defined

### Forms (`packages/forms/package.json`)
- [x] `"name": "@noraeb/forms"`
- [x] `"publishConfig": { "access": "public" }`
- [x] `"files"` field defined

### Wizards (`packages/wizards/package.json`)
- [x] `"name": "@noraeb/wizards"`
- [x] `"publishConfig": { "access": "public" }`
- [x] `"files"` field defined

### Addons (`packages/addons/package.json`)
- [x] `"name": "@noraeb/addons"`
- [x] `"publishConfig": { "access": "public" }`
- [x] `"files"` field defined

### Plugins (`packages/plugins/package.json`)
- [x] `"name": "@noraeb/plugins"`
- [x] `"publishConfig": { "access": "public" }`
- [x] Build script configured

### Distribution (`packages/distribution/package.json`)
- [x] `"private": true` (should NOT be published)

## GitHub Configuration

- [x] `.github/workflows/release-please.yml` configured with publish steps
- [x] `release-please-config.json` includes all packages
- [x] Workflow has `contents: write` and `pull-requests: write` permissions

## Testing the Setup

After setup, test the automated publishing:

1. [ ] **Create a test commit**
   ```bash
   git checkout -b test/npm-publishing
   echo "# Test" >> README.md
   git add README.md
   git commit -m "feat: test automated npm publishing"
   git push origin test/npm-publishing
   ```

2. [ ] **Create and merge PR to main**
   - Create PR from `test/npm-publishing` to `main`
   - Merge the PR

3. [ ] **Wait for Release Please PR**
   - Release Please bot should create a PR with version bumps
   - Review the PR to ensure all packages are updated

4. [ ] **Merge Release PR**
   - Merge the Release Please PR
   - This triggers the automated publishing

5. [ ] **Verify Publishing**
   - Check GitHub Actions logs for successful publishes
   - Verify packages on NPM: `npm view @noraeb/core`
   - Check GitHub releases for build artifacts

## Troubleshooting Checklist

If publishing fails:

- [ ] Check GitHub Actions logs for error messages
- [ ] Verify NPM_TOKEN secret is set correctly
- [ ] Confirm NPM token has not expired
- [ ] Ensure all packages build successfully locally: `npm run build`
- [ ] Check NPM organization permissions
- [ ] Verify package.json files have correct configuration
- [ ] Ensure versions in package.json files are valid semver

## Maintenance

Regular maintenance tasks:

- [ ] **Monthly**: Verify NPM token hasn't expired
- [ ] **After major changes**: Test build and publish locally
- [ ] **Before releases**: Review all package.json dependencies
- [ ] **Quarterly**: Review and update this checklist

## Quick Commands

```bash
# Check current versions
lerna list --long

# Build all packages
npm run build

# Test publish (dry-run) for a specific package
cd packages/core
npm publish --dry-run --access public

# View package on NPM
npm view @noraeb/core

# Check NPM organization access
npm access ls-packages @noraeb

# Login to NPM (if needed)
npm login
```

## Status

- **Setup Date**: [Add date when completed]
- **Last Successful Publish**: [Update after first successful publish]
- **NPM Token Expiry**: [Add expiry date if applicable]
- **Maintainer**: [Add your name/team]

---

**Note**: This checklist should be reviewed and updated whenever the publishing process changes.
