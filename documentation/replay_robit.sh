#!/bin/bash

# remove the previous robit run
rm -rf robit/
rm -rf __pycache__/
# launch the process saving stdout to aaa_log.txt file
# the process generate also a swatplus_aw_log.txt
# but this does not display evetual errors
echo "start"
swatplus_aw.sh |& tee aaa_log.txt
echo "done"
