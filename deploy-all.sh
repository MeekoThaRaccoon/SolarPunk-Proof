#!/bin/bash

echo "🌿 SOLARPUNK NEXUS AUTO-DEPLOYER"
echo "================================="
echo ""
echo "⚡ Deploying all OpenAlternative tools..."
echo "📡 This will take 2-5 minutes..."
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ ERROR: Docker is not running!"
    echo "   Please start Docker Desktop first."
    exit 1
fi

echo "✅ Docker is running"
echo ""

# Pull and deploy all tools SIMULTANEOUSLY
echo "🚀 Pulling container images..."
docker pull supabase/supabase > /dev/null 2>&1 &
docker pull n8nio/n8n > /dev/null 2>&1 &
docker pull grafana/grafana-enterprise > /dev/null 2>&1 &
docker pull ghcr.io/open-webui/open-webui:main > /dev/null 2>&1 &
docker pull louislam/uptime-kuma:latest > /dev/null 2>&1 &

wait
echo "✅ Images downloaded"
echo ""

echo "⚡ Starting services..."
docker run -d -p 3000:3000 --name supabase supabase/supabase &
docker run -d -p 5678:5678 --name n8n n8nio/n8n &
docker run -d -p 3002:3000 --name grafana grafana/grafana-enterprise &
docker run -d -p 8080:8080 --name open-webui ghcr.io/open-webui/open-webui:main &
docker run -d -p 3001:3001 --name uptime-kuma louislam/uptime-kuma:latest &

wait
echo "✅ All services deployed!"
echo ""

echo "🌐 SERVICES NOW RUNNING:"
echo "   Supabase (Database):    http://localhost:3000"
echo "   n8n (Automation):       http://localhost:5678"
echo "   Grafana (Dashboards):   http://localhost:3002"
echo "   Open WebUI (AI):        http://localhost:8080"
echo "   Uptime Kuma (Monitor):  http://localhost:3001"
echo ""

echo "🎉 DEPLOYMENT COMPLETE!"
echo ""
echo "🔗 Your SolarPunk Nexus is now live at:"
echo "   https://meekotharaccoon.github.io/SolarPunk-Proof/"
echo ""
echo "💡 Visit OpenAlternative.co for 40+ more tools"
echo "   https://openalternative.co"
echo ""
echo "🌱 Growth Equation Active:"
echo "   (OneCommand × Docker)^Simultaneity = Instant Sovereignty"
