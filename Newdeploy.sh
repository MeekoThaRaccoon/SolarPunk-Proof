#!/bin/bash
# SOLARPUNK NEXUS DEPLOYER - ONE COMMAND

echo "🌱 SOLARPUNK NEXUS v2.0"
echo "📈 (OpenSource × Docker)^Simultaneity × Network Effect"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop first."
    exit 1
fi

# Pull and run all containers SIMULTANEOUSLY
echo "🚀 Pulling containers (this may take a few minutes)..."
docker pull supabase/supabase > /dev/null 2>&1 &
docker pull n8nio/n8n > /dev/null 2>&1 &
docker pull ghcr.io/open-webui/open-webui:main > /dev/null 2>&1 &
docker pull grafana/grafana-enterprise > /dev/null 2>&1 &
docker pull louislam/uptime-kuma:latest > /dev/null 2>&1 &
wait

echo "✅ Containers pulled!"
echo ""

# Run all services SIMULTANEOUSLY
echo "⚡ Starting services..."
docker run -d -p 3000:3000 --name supabase supabase/supabase &
docker run -d -p 5678:5678 --name n8n n8nio/n8n &
docker run -d -p 8080:8080 --name open-webui ghcr.io/open-webui/open-webui:main &
docker run -d -p 3002:3000 --name grafana grafana/grafana-enterprise &
docker run -d -p 3001:3001 --name uptime-kuma louislam/uptime-kuma:latest &
wait

echo "🎉 DEPLOYMENT COMPLETE!"
echo ""
echo "🌐 SERVICES RUNNING AT:"
echo "   Supabase (Database):    http://localhost:3000"
echo "   n8n (Automation):       http://localhost:5678"
echo "   Open WebUI (AI):        http://localhost:8080"
echo "   Grafana (Dashboard):    http://localhost:3002"
echo "   Uptime Kuma (Monitor):  http://localhost:3001"
echo ""
echo "🔗 Open Nexus Dashboard:"
echo "   https://meekotharaccoon.github.io/SolarPunk-Proof/nexus.html"
echo ""
echo "📊 Growth equation active:"
echo "   (OneCommand × Simultaneity) × OpenSource = Instant Sovereignty"
