#!/bin/bash
echo "=== Keylime Source Verification ==="
echo ""

if [ -d /var/tmp/keylime_sources ]; then
    cd /var/tmp/keylime_sources
    
    echo "📍 Location: $(pwd)"
    echo ""
    
    echo "🌿 Git Status:"
    git status | head -10
    echo ""
    
    echo "📝 Current Commit:"
    git log -1 --format="%H %s"
    echo ""
    
    echo "🔗 Remote:"
    git remote -v | head -2
    echo ""
    
    echo "📊 Recent Commits (last 5):"
    git log --oneline -5
    echo ""
    
    echo "🔍 PR #1693 Related Files:"
    if [ -f keylime/migrations/versions/870c218abd9a_add_push_attestation_support.py ]; then
        echo "✅ Migration file exists (PR #1693 specific)"
    else
        echo "❌ Migration file NOT found (may not be PR #1693)"
    fi
    
    if grep -q "accept_attestations" keylime/migrations/versions/870c218abd9a_add_push_attestation_support.py 2>/dev/null; then
        echo "✅ Migration contains 'accept_attestations' column"
    fi
    
    echo ""
    echo "📦 Installed Keylime Location:"
    python3 -c "import keylime; print(keylime.__file__)" 2>/dev/null || echo "Not installed yet"
    
else
    echo "❌ /var/tmp/keylime_sources NOT FOUND"
    echo "The keylime source may not have been cloned yet."
fi
