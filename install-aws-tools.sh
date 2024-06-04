#!/bin/bash
sudo apt install awscli

git clone https://github.com/nccgroup/ScoutSuite \
&& cd ScoutSuite \
&& virtualenv -p python3 venv \
&& source venv/bin/activate \
&& pip install -r requirements.txt \
&& cd ..
#rem python scout.py --help

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

mkdir aws_escalate \
&& curl -o aws_escalate/aws_escalate.py https://raw.githubusercontent.com/RhinoSecurityLabs/Security-Research/master/tools/aws-pentest-tools/aws_escalate.py \
&& pip install boto3 \
&& chmod 700 aws_escalate/aws_escalate.py

sudo /bin/sh -c "$(curl -fsSL https://steampipe.io/install/steampipe.sh)" \
&& steampipe plugin install aws

sudo /bin/sh -c "$(curl -fsSL https://powerpipe.io/install/powerpipe.sh)" \
&& mkdir pp-dashboards && cd pp-dashboards \
&& powerpipe mod init \
&& powerpipe mod install github.com/turbot/steampipe-mod-aws-compliance

pip install prowler

pip3 install -U pacu
echo "You may get a pip error there installing pacu but it seems to work ok"
