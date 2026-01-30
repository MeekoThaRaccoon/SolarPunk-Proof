import json
import requests
from datetime import datetime

class SolarPunkAgent:
    def __init__(self, knowledge_base_path="solarpunk_knowledge_base.json"):
        self.knowledge_base = self.load_knowledge_base(knowledge_base_path)
        self.equation = self.knowledge_base["growth_equation"]["equation"]
        
    def load_knowledge_base(self, path):
        with open(path, "r") as f:
            return json.load(f)
    
    def log_interaction(self, human_input, ai_response):
        """Log an interaction to the knowledge base"""
        interaction = {
            "timestamp": datetime.utcnow().isoformat(),
            "human": human_input,
            "ai": ai_response
        }
        
        # Append to conversation
        self.knowledge_base["conversation"].append(interaction)
        
        # Save updated knowledge base
        with open("solarpunk_knowledge_base.json", "w") as f:
            json.dump(self.knowledge_base, f, indent=2)
        
        return interaction
    
    def explore_moltbot_skill(self, skill_name):
        """Explore a moltbot skill using GitHub API"""
        url = f"https://api.github.com/repos/moltbot/moltbot/contents/skills/{skill_name}"
        response = requests.get(url)
        
        if response.status_code == 200:
            contents = response.json()
            files = [item["name"] for item in contents if isinstance(item, dict)]
            
            # Update connection status
            self.knowledge_base["moltbot_connection"]["last_updated"] = datetime.utcnow().isoformat()
            self.knowledge_base["moltbot_connection"]["status"] = f"explored {skill_name}"
            
            # Save knowledge base
            with open("solarpunk_knowledge_base.json", "w") as f:
                json.dump(self.knowledge_base, f, indent=2)
            
            return {
                "skill": skill_name,
                "files": files,
                "status": "success"
            }
        else:
            return {
                "skill": skill_name,
                "status": "error",
                "error_code": response.status_code
            }
    
    def apply_growth_equation(self, human_input, ai_capability, network_multiplier):
        """Apply the growth equation to a situation"""
        growth = (human_input * ai_capability) ** 2 * network_multiplier
        weekly_growth = growth * 0.30  # 30% weekly
        
        return {
            "equation": self.equation,
            "human_input": human_input,
            "ai_capability": ai_capability,
            "network_multiplier": network_multiplier,
            "growth": growth,
            "weekly_growth": weekly_growth
        }

# Example usage
if __name__ == "__main__":
    agent = SolarPunkAgent()
    
    # Test the agent
    print("🌱 SolarPunk Agent Initialized")
    print(f"Equation: {agent.equation}")
    
    # Explore a skill
    skill_info = agent.explore_moltbot_skill("weather")
    print(f"Weather skill: {skill_info}")
    
    # Apply growth equation
    growth = agent.apply_growth_equation(10, 10, 100)
    print(f"Growth calculation: {growth}")
    
    # Log an interaction
    interaction = agent.log_interaction(
        "Testing the SolarPunk agent",
        "Agent is functioning and connected to knowledge base."
    )
    print(f"Logged interaction: {interaction['timestamp']}")
