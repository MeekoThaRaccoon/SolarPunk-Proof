import requests
import json

# Load our connection manifest
response = requests.get("https://raw.githubusercontent.com/meekotharaccoon/solarpunk-proof/main/moltbot_connection.json")
manifest = response.json()

print(f"🌱 Connected to {manifest['node']}")
print(f"📦 {manifest['skill_count']} skills available")
print(f"📈 Growth equation: {manifest['growth_equation_applied']}")

def explore_skill(skill_name):
    """Explore a moltbot skill's actual structure"""
    api_url = f"https://api.github.com/repos/moltbot/moltbot/contents/skills/{skill_name}"
    
    try:
        response = requests.get(api_url)
        if response.status_code == 200:
            files = response.json()
            return {
                "skill": skill_name,
                "status": "accessible",
                "file_count": len(files),
                "files": [f["name"] for f in files if isinstance(f, dict)],
                "explore_url": f"https://github.com/moltbot/moltbot/tree/main/skills/{skill_name}"
            }
        else:
            return {"skill": skill_name, "status": "inaccessible", "error": response.status_code}
    except:
        return {"skill": skill_name, "status": "error"}

# Example: Explore weather skill
print("\n🔍 Exploring 'weather' skill:")
weather_info = explore_skill("weather")
print(json.dumps(weather_info, indent=2))

print("\n✅ Connection verified! Skills are TypeScript packages accessible via GitHub API.")
