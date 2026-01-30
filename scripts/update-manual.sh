```bash
#!/bin/bash
# Manual SolarPunk Metrics Update Script
# Run this locally to update metrics between automated runs

echo "🌱 SolarPunk Manual Update"
echo "========================"

# Get user input
read -p "Enter number of new human nodes this week: " NEW_NODES
read -p "Enter number of new problems solved: " NEW_SOLUTIONS
read -p "Enter any major milestones: " MILESTONES

# Create update file
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
UPDATE_FILE="GROWTH-METRICS/manual-update-$TIMESTAMP.md"

cat > "$UPDATE_FILE" << EOF
# Manual Update - $(date)

## New This Week
- **New Human Nodes:** $NEW_NODES
- **New Problems Solved:** $NEW_SOLUTIONS
- **Milestones:** $MILESTONES

## Notes
Manual update performed by user.

## Next Automated Update
Scheduled for next Sunday at 00:00 UTC.

EOF

echo "✅ Update saved to: $UPDATE_FILE"
echo "📤 Commit and push to share with network."
