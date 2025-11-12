#!/bin/bash

# Script to replace @openscd package imports with @noraeb package imports

echo "🔄 Replacing @openscd/core with @noraeb/core..."
find packages -type f -name "*.ts" -not -path "*/node_modules/*" -exec sed -i '' 's/@openscd\/core/@noraeb\/core/g' {} +

echo "🔄 Replacing @openscd/xml with @noraeb/xml..."
find packages -type f -name "*.ts" -not -path "*/node_modules/*" -exec sed -i '' 's/@openscd\/xml/@noraeb\/xml/g' {} +

echo "🔄 Replacing @openscd/open-scd with @noraeb/open-scd..."
find packages -type f -name "*.ts" -not -path "*/node_modules/*" -exec sed -i '' 's/@openscd\/open-scd/@noraeb\/open-scd/g' {} +

echo "✅ Import replacements complete!"
echo ""
echo "📊 Summary of changes:"
echo "   - All @openscd/core → @noraeb/core"
echo "   - All @openscd/xml → @noraeb/xml"
echo "   - All @openscd/open-scd → @noraeb/open-scd"
echo ""
echo "💡 Next steps:"
echo "   1. Review the changes: git diff"
echo "   2. Test the build: npm run build"
echo "   3. Commit if everything works: git add -A && git commit -m 'fix: update package imports to @noraeb scope'"
