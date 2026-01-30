#!/bin/bash
echo "🌱 SolarPunk Nexus Deployer"
echo ""

# Check Docker
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker not running. Start Docker Desktop first."
    exit 1
fi

echo "🚀 Starting services..."
echo "This will take 2-3 minutes."

# Start only essential services
docker run -d -p 3000:3000 --name supabase supabase/supabase >/dev/null 2>&1 &
docker run -d -p 5678:5678 --name n8n n8nio/n8n >/dev/null 2>&1 &
docker run -d -p 3001:3001 --name uptime-kuma louislam/uptime-kuma >/dev/null 2>&1 &

wait

echo ""
echo "✅ Deployment Complete!"
echo ""
echo "🌐 Services:"
echo "   Supabase:    http://localhost:3000"
echo "   n8n:         http://localhost:5678"
echo "   Uptime Kuma: http://localhost:3001"
echo ""
echo "📊 Visit Nexus:"
echo "   https://meekotharaccoon.github.io/SolarPunk-Proof/nexus.html"
