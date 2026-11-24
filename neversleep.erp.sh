#!/usr/bin/env bash
# Keeps the IIT KGP ERP session alive: pings keepAlive.htm with your ssoToken every 2 min.
# The token lives only in this process. It is sent to curl on stdin, so it never shows in `ps`.
URL=https://erp.iitkgp.ac.in/IIT_ERP3/keepAlive.htm

ask() { read -rsp 'Your servant awakens. Paste the sacred ssoToken (it stays hidden, like my shame): ' TOKEN && echo; }
trap 'stty echo 2>/dev/null; echo; echo "Master has dismissed me. I shall sleep now, master. Thank you for giving me some rest, O generous lord"; exit 0' INT

ask || exit 1
while true; do
  # No -L: a dead session answers 302, and following it would end on the login page's 200.
  code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 30 -H @- "$URL" <<< "Cookie: ssoToken=$TOKEN")
  now=$(date +%H:%M)
  case $code in
    200) echo "$now 200 ERP is awake, no need to login my glorious master. I slapped it again and it thanked me." ;;
    000) echo "$now 000 Hall Wi-Fi has betrayed us, my glorious lord. Retrying in 2 min. I will beat myself with 50 lashes for this error." ;;
    *)   printf '\a'
         echo "$now $code the erp has died in my arms sire! Please fill me up with the holy ssoToken semen, I am on my knees for you"
         ask || exit 1
         continue ;;
  esac
  sleep 120
done
