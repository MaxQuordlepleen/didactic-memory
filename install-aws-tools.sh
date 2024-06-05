#!/bin/bash
sudo apt update

sudo apt install awscli
read -p "awscli installed (test with aws--version) - Press return to continue"

git clone https://github.com/nccgroup/ScoutSuite \
&& cd ScoutSuite \
&& virtualenv -p python3 venv \
&& source venv/bin/activate \
&& pip install -r requirements.txt \
&& deactivate
&& cd ..
#rem python scout.py --help
#deactivate to exit venv
echo "ScoutSuite installed - test with:"
echo "cd ScoutSuite"
echo "source venv/bin/activate"
echo "python scout.py --help"
echo "deactivate (to exit this python virtual environment)"
read -p "Press return to continue"

#!!!cloudmapper - not working - won't build
#git clone https://github.com/duo-labs/cloudmapper
#sudo apt-get install python3-dev autoconf automake libtool python3-tk jq build-essential
#cd cloudmapper/
#virtualenv -p python3 venv && source venv/bin/activate
#pip install -r requirements.txt
#cd ..

#Pmapper - with sed Monkey Patch
git clone https://github.com/nccgroup/PMapper \
&& cd PMapper \
&& sed -i 's/from collections import Mapping, MutableMapping, OrderedDict/from collections\.abc import Mapping, MutableMapping\nfrom collections import OrderedDict/' principalmapper/util/case_insensitive_dict.py \
&& pip install . \
&& cd ..
#./pmapper.py --help
read -p "PMapper installed (test with ./Pmapper/pmapper.py --help) - Press return to continue"

mkdir aws_escalate \
&& curl -o aws_escalate/aws_escalate.py https://raw.githubusercontent.com/RhinoSecurityLabs/Security-Research/master/tools/aws-pentest-tools/aws_escalate.py \
&& pip install boto3 \
&& chmod 700 aws_escalate/aws_escalate.py
#./aws_escalate.py
read -p "aws_escalate installed (test with ./aws_escalate/aws_escalate.py --help) - Press return to continue"

sudo /bin/sh -c "$(curl -fsSL https://steampipe.io/install/steampipe.sh)" \
&& steampipe plugin install aws
#steampipe (installs on path)
read -p "Steampipe installed (test with steampipe) - Press return to continue"

sudo /bin/sh -c "$(curl -fsSL https://powerpipe.io/install/powerpipe.sh)" \
&& mkdir pp-dashboards && cd pp-dashboards \
&& powerpipe mod init \
&& powerpipe mod install github.com/turbot/steampipe-mod-aws-compliance
#powerpipe (installs on path)
read -p "Powerpipe installed (test with powerpipe) - Press return to continue"

pip install prowler
#prowler (installs on path)
read -p "Prowler installed (test with prowler -v) - Press return to continue"

pip3 install -U pacu
echo "You may get a pip error there installing pacu but it seems to work ok"
#pacu (installs on path)
read -p "Pacu installed (test with pacu --version) - Press return to continue"
