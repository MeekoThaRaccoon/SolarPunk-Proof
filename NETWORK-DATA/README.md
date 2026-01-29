# SolarPunk Network Directory

## How to Add Your Node

1. **Fork** this repository
2. **Create a new file** in `NETWORK-DATA/YOUR-USERNAME.md`
3. **Use this template:**

```markdown
# [Your Name or Alias]

## Node Information
- **Location:** [City, Country]
- **Start Date:** [YYYY-MM-DD]
- **Focus Areas:** [e.g., Education, Environment, Healthcare]
- **Preferred AI Tools:** [e.g., ChatGPT, Claude, Copilot]

## Current Projects
1. **Project Name:** [Brief description]
   - Status: [In progress/Completed]
   - Collaboration: [Solo/With AI/With others]
   - Documentation: [Link to your proof]

## Growth Metrics
- **Starting Points:** [What you began with]
- **Current Status:** [Where you are now]
- **Weekly Growth:** [Your measured growth rate]

## Contact/Connect
- [Your preferred contact method, if any]
- [Link to your SolarPunk proof document]

## Verification
I confirm this information is accurate and my SolarPunk work is documented transparently.

Signed,
[Your name/alias]

Network Rules
Be transparent

Document everything

Respect privacy

Grow at your own pace

Support other nodes

Current Nodes
Name	Location	Start Date	Focus
[First User]	[Location]	[Date]	[Focus]
Add your node here			
text

4. **Click "Commit new file"**

---

## **PART 4: CREATE MANUAL UPDATE SCRIPT**

1. **Click "Add file" → "Create new file"**
2. **File name:** `scripts/update-manual.sh`
3. **Paste:**

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
