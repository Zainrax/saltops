#!/bin/bash
# This is to help testing salt changes on a Raspberry Pi
# Usage: state-apply-test.sh [devicename] [state.apply params]
# If you need to make changes to rpi-top.sls make the changes in `salt/top.sls` This is what is used when testing

device=$1
params=$2

set -e

if [[ -z $device ]]; then
  echo "please provide device name. Usage \`state-apply-test-tc2.sh [devicename] [state.apply params]\`"
  exit 1
fi

if [[ -e salt ]]; then
  rm -r salt 
fi
mkdir salt

# copy files to local folder
cp -r basics.sls _modules/ tc2/ _states/ salt-migration/ timezone.sls salt/
cp tc2-top.sls salt/top.sls

ssh pi@$device "sudo rm -rf salt /srv/salt"

# copy onto device
echo "copying files to device.."
scp -rq salt pi@$device:
echo "done"

echo "Deleting old salt files.."
ssh pi@$device "sudo rm -r /srv/salt 2>/dev/null || true"

echo "moving files to /srv"
ssh pi@$device "sudo cp -r salt /srv/"
echo "done"

#echo "Sync salt, this updates the _modules files."
#ssh -t pi@$device "sudo salt-call --local saltutil.sync_all"

cmd="ssh -t pi@$device \"sudo salt-call --local state.apply $params --state-output=changes\""
echo "running $cmd"
eval $cmd