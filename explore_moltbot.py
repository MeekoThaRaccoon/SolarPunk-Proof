import requests
import json
import time

def get_all_skills():
    """Get all skills from the moltbot repository"""
    url = "https://api.github.com/repos/moltbot/moltbot/contents/skills"
    response = requests.get(url)
    if response.status_code == 200:
        return response.json()
    else:
        print(f"Error fetching skills: {response.status_code}")
        return []

def explore_skill(skill_name):
    """Explore a single skill's structure"""
    url = f"https://api.github.com/repos/moltbot/moltbot/contents/skills/{skill_name}"
    response = requests.get(url)
    if response.status_code == 200:
        contents = response.json()
        # Extract file names and types
        files = []
        for item in contents:
            if isinstance(item, dict):
                files.append({
                    "name": item["name"],
                    "type": item["type"],
                    "url": item.get("download_url", "")
                })
        return files
    else:
        print(f"Error fetching skill {skill_name}: {response.status_code}")
        return []

def generate_connection_map():
    """Generate a connection map for all skills"""
    skills = get_all_skills()
    connection_map = {
        "total_skills": len(skills),
        "skills": []
    }
    
    for skill in skills:
        skill_name = skill["name"]
        print(f"Exploring {skill_name}...")
        files = explore_skill(skill_name)
        
        # Determine capability based on files
        capability = "unknown"
        file_names = [f["name"] for f in files]
        if "index.ts" in file_names:
            capability = "TypeScript skill"
        elif "package.json" in file_names:
            capability = "Node.js package"
        elif any(f.endswith(".py") for f in file_names):
            capability = "Python script"
        elif "SKILL.md" in file_names:
            capability = "AI skill with documentation"
        
        skill_info = {
            "name": skill_name,
            "capability": capability,
            "files": file_names,
            "github_url": f"https://github.com/moltbot/moltbot/tree/main/skills/{skill_name}"
        }
        
        connection_map["skills"].append(skill_info)
        
        # Be respectful to GitHub API rate limits
        time.sleep(0.1)
    
    return connection_map

if __name__ == "__main__":
    print("🚀 Exploring moltbot skills...")
    connection_map = generate_connection_map()
    
    with open("moltbot_connection_map.json", "w") as f:
        json.dump(connection_map, f, indent=2)
    
    print(f"✅ Successfully explored {connection_map['total_skills']} skills")
    print("📁 Saved to moltbot_connection_map.json")
