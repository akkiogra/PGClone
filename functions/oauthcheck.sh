#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
oauthcheck () {
pgclonevars

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Conducting Validation Checks: $oauthcheck
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /opt/appdata/plexguide/.$oauthcheck $oauthcheck: | grep -oP plexguide | head -n1)
  if [[ "$rcheck" != "plexguide" ]]; then
    rclone mkdir --config /opt/appdata/plexguide/.$oauthcheck $oauthcheck:/plexguide
    rcheck=$(rclone lsd --config /opt/appdata/plexguide/.$oauthcheck $oauthcheck: | grep -oP plexguide | head -n1)
  fi

  if [[ $oauthcheck == "tcrypt" ]]; then encrypt27=tdrive; fi
  if [[ $oauthcheck == "gcrypt" ]]; then encrypt27=gdrive; fi

  if [[ "$encrypt27" == "tdrive" || "$encrypt27" == "gdrive" ]]; then
    echeck=$(rclone lsd --config /opt/appdata/plexguide/.${encrypt27} ${encrypt27}: | grep -oP encrypt | head -n1)
    if [[ "$echeck" != "encrypt" ]]; then
      rclone mkdir --config /opt/appdata/plexguide/.${encrypt27} ${encrypt27}:/encrypt
    fi
  fi

  if [ "$rcheck" != "plexguide" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  Validation Checks Failed: $oauthcheck
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTES:
1. Did you set up your $oauthcheck accordingly to the wiki?

EOF
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
    clonestart
else
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Validation Checks Passed - $oauthcheck
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  fi
}