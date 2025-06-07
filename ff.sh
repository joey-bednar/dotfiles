#!/usr/bin/env bash

# Define extension URLs from Mozilla Add-ons
EXTENSIONS=(
  "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
  "https://addons.mozilla.org/firefox/downloads/latest/https-everywhere/latest.xpi"
)

# Firefox policy directory
POLICY_DIR="$HOME/.mozilla/firefox-policies"
mkdir -p "$POLICY_DIR"

# Create policies.json with extension install URLs
cat > "$POLICY_DIR/policies.json" <<EOF
{
  "policies": {
    "Extensions": {
      "Install": [
        "${EXTENSIONS[0]}",
        "${EXTENSIONS[1]}"
      ]
    }
  }
}
EOF

echo "[INFO] Created policies.json at $POLICY_DIR"

# Install Firefox (Debian/Ubuntu example)
if ! command -v firefox >/dev/null; then
  echo "[INFO] Installing Firefox..."
  sudo apt update && sudo apt install -y firefox
fi

# Launch Firefox with custom policy directory
echo "[INFO] Launching Firefox with policies..."
mkdir -p "$HOME/.mozilla/firefox"
FIREFOX_DIST_DIR="$HOME/.mozilla/firefox/distribution"
mkdir -p "$FIREFOX_DIST_DIR"
cp "$POLICY_DIR/policies.json" "$FIREFOX_DIST_DIR/policies.json"

firefox --no-remote --new-instance &
