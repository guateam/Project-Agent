cd /etc/project-agent/venv
source bin/activate
cd ..
nohup python /etc/project-agent/API/api.py >project-agent.log &
deactivate
cd ~