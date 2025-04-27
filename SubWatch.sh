#!/usr/bin/env bash

cat << "EOF"
    _____       __  _       __      __       __
   / ___/__  __/ /_| |     / /___ _/ /______/ /_
   \__ \/ / / / __ \ | /| / / __ `/ __/ ___/ __ \
  ___/ / /_/ / /_/ / |/ |/ / /_/ / /_/ /__/ / / /
 /____/\__,_/_.___/|__/|__/\__,_/\__/\___/_/ /_/

            Made with ❤️ by Brut Security

EOF

cd "$(dirname "$0")"

DOMAINS_FILE="domains.txt"

if [[ ! -f "$DOMAINS_FILE" ]]; then
    echo "❌ domains.txt not found."
    exit 1
fi

if [[ -z "$DISCORD_WEBHOOK" ]]; then
    echo "❌ Please set your Discord webhook:"
    echo "export DISCORD_WEBHOOK='your_webhook_url'"
    exit 1
fi

# Send plain text messages via notify
notify_status() {
    local message="$1"
    echo "$message" | notify -silent -provider discord -id subs
}

# First time webhook check
if [[ ! -f ".webhook_verified" ]]; then
    notify_status "✅ **Webhook configured successfully!** _(Initial verification)_"
    touch ".webhook_verified"
fi

# Loop forever
while true; do
    notify_status "🔄 Subdomain Monitoring Scan Started!"

    while IFS= read -r domain || [[ -n "$domain" ]]; do
        [[ -z "$domain" || "$domain" =~ ^# ]] && continue

        echo "[*] Scanning $domain"
        notify_status "🟡 Scanning: \`$domain\`"

        current_file="${domain}-current.txt"
        new_file="${domain}-new.txt"

        # Run subfinder and capture new subdomains
        subfinder -d "$domain" -silent | anew "$current_file" > "$new_file"

        if [[ -s "$new_file" ]]; then
            count=$(wc -l < "$new_file")
            notify_status "🚨 $count new subdomains found for \`$domain\` _(Details in attached file)_"

            curl -s -X POST "$DISCORD_WEBHOOK" \
                -F "file=@$new_file" \
                -F "payload_json={\"content\": \"📄 Subdomain list for \`$domain\`\"}" >/dev/null
        else
            notify_status "✅ No new subdomains found for \`$domain\` _(source: \`subfinder\`)_"
        fi

        rm -f "$new_file"
    done < "$DOMAINS_FILE"

    notify_status "😴 Monitoring complete. Sleeping for 6 hours..."
    sleep 21600  # 6 hours
done