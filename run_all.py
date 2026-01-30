import subprocess
import sys

scripts = ["explore_moltbot.py", "create_knowledge_base.py", "solarpunk_agent.py"]

for script in scripts:
    print(f"🚀 Running {script}...")
    result = subprocess.run([sys.executable, script], capture_output=True, text=True)
    print(result.stdout)
    if result.stderr:
        print(f"Errors in {script}: {result.stderr}")
    print()
