#!/bin/bash
# CONNECT ALL SERVICES VIA n8n WORKFLOWS

echo "🔗 CREATING SIMULTANEOUS WORKFLOWS..."

# Create the main orchestration workflow
cat > n8n-workflow-solarpunk.json << 'EOF'
{
  "name": "SolarPunk Nexus Orchestrator",
  "nodes": [
    {
      "name": "Impact Trigger",
      "type": "n8n-nodes-base.manualTrigger",
      "position": [250, 300]
    },
    {
      "name": "Log to Supabase",
      "type": "n8n-nodes-base.postgres",
      "position": [450, 300],
      "parameters": {
        "host": "localhost",
        "database": "postgres",
        "user": "postgres",
        "password": "solarpunk",
        "operation": "insert",
        "table": "impact_events"
      }
    },
    {
      "name": "Generate AI Analysis",
      "type": "n8n-nodes-base.httpRequest",
      "position": [650, 250],
      "parameters": {
        "url": "http://localhost:8080/api/v1/chat/completions",
        "requestMethod": "POST",
        "sendBody": true,
        "bodyParameters": {
          "parameters": [
            {
              "name": "model",
              "value": "open-webui"
            },
            {
              "name": "messages",
              "value": "[{\"role\":\"user\",\"content\":\"Analyze this SolarPunk impact\"}]"
            }
          ]
        }
      }
    },
    {
      "name": "Send Notification",
      "type": "n8n-nodes-base.httpRequest",
      "position": [650, 350],
      "parameters": {
        "url": "http://localhost:3000/v1/events/trigger",
        "requestMethod": "POST"
      }
    },
    {
      "name": "Post to Social",
      "type": "n8n-nodes-base.httpRequest",
      "position": [850, 300],
      "parameters": {
        "url": "http://localhost:3003/api/v1/posts",
        "requestMethod": "POST"
      }
    },
    {
      "name": "Update Dashboard",
      "type": "n8n-nodes-base.httpRequest",
      "position": [1050, 300],
      "parameters": {
        "url": "http://localhost:3002/api/dashboards/db",
        "requestMethod": "POST"
      }
    }
  ],
  "connections": {
    "Impact Trigger": {
      "main": [
        [
          {
            "node": "Log to Supabase",
            "type": "main",
            "index": 0
          },
          {
            "node": "Generate AI Analysis",
            "type": "main",
            "index": 0
          },
          {
            "node": "Send Notification",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Log to Supabase": {
      "main": [
        [
          {
            "node": "Post to Social",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Generate AI Analysis": {
      "main": [
        [
          {
            "node": "Update Dashboard",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "Send Notification": {
      "main": [
        [
          {
            "node": "Update Dashboard",
            "type": "main",
            "index": 0
          }
        ]
      ]
    }
  }
}
EOF

echo "✅ Main workflow created: n8n-workflow-solarpunk.json"
echo ""
echo "🚀 TO DEPLOY WORKFLOW:"
echo "   1. Open n8n at http://localhost:5678"
echo "   2. Click 'Workflows' → 'Import from file'"
echo "   3. Select n8n-workflow-solarpunk.json"
echo "   4. Click 'Execute Workflow' to test"
echo ""
echo "🌱 This connects:"
echo "   Impact → Database → AI Analysis → Notifications → Social → Dashboard"
echo "   ALL SIMULTANEOUSLY!"
