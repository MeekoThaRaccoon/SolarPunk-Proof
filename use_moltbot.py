import requests
import json

def get_skill_structure(skill_name):
    """Get the actual structure of a moltbot skill"""
    api_url = f"https://api.github.com/repos/moltbot/moltbot/contents/skills/{skill_name}"
    response = requests.get(api_url)
    
    if response.status_code == 200:
        files = response.json()
        skill_type = "unknown"
        
        # Determine skill type based on files
        for file in files:
            if file['name'] == 'index.ts':
                skill_type = "TypeScript skill"
            elif file['name'] == 'package.json':
                skill_type = "Node.js package"
            elif file['name'] == 'SKILL.md':
                skill_type = "Documented AI skill"
        
        return {
            "skill": skill_name,
            "type": skill_type,
            "files": [f["name"] for f in files],
            "api_url": api_url,
            "raw_index_url": f"https://raw.githubusercontent.com/moltbot/moltbot/main/skills/{skill_name}/index.ts"
        }
    else:
        return {"error": f"Cannot access skill: {skill_name}"}

# Test with weather skill
print("🌤️ Testing weather skill structure:")
weather_structure = get_skill_structure("weather")
print(json.dumps(weather_structure, indent=2))

# Test with skill-creator (has SKILL.md)
print("\n🛠️ Testing skill-creator structure:")
creator_structure = get_skill_structure("skill-creator")
print(json.dumps(creator_structure, indent=2))
