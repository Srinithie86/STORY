#!/usr/bin/env bash
set -e
set -o pipefail

echo "=========================================="
echo "Starting Cloudflare Pages Flutter Web Build"
echo "=========================================="

# 1. Install or locate Flutter SDK
if command -v flutter >/dev/null 2>&1; then
  echo "Flutter already available in PATH: $(which flutter)"
elif [ -x "$HOME/flutter/bin/flutter" ]; then
  echo "Found Flutter SDK in $HOME/flutter/bin"
  export PATH="$HOME/flutter/bin:$PATH"
elif [ -x "/tmp/flutter/bin/flutter" ]; then
  echo "Found Flutter SDK in /tmp/flutter/bin"
  export PATH="/tmp/flutter/bin:$PATH"
else
  FLUTTER_DIR="${FLUTTER_INSTALL_DIR:-$HOME/flutter}"
  echo "Flutter not found. Installing stable Flutter SDK to $FLUTTER_DIR..."
  git config --global --add safe.directory '*' || true
  git clone --depth 1 --branch stable https://github.com/flutter/flutter.git "$FLUTTER_DIR"
  export PATH="$FLUTTER_DIR/bin:$PATH"
fi

# Ensure git safe directory for Flutter root
if [ -n "$FLUTTER_DIR" ] && [ -d "$FLUTTER_DIR" ]; then
  git config --global --add safe.directory "$FLUTTER_DIR" || true
fi

# Configure Flutter
flutter config --no-analytics

# 2. Display Flutter version
echo "--- Flutter Version ---"
flutter --version

# 3. Fetch dependencies
echo "--- Flutter Pub Get ---"
flutter pub get

# 4. Build web release
echo "--- Building Web Release ---"
flutter build web --release

# 5. Ensure SPA redirects and 404 handler exist in output directory
if [ -f "web/_redirects" ] && [ ! -f "build/web/_redirects" ]; then
  cp web/_redirects build/web/_redirects
fi

if [ -f "web/404.html" ] && [ ! -f "build/web/404.html" ]; then
  cp web/404.html build/web/404.html
fi

# 6. Verify output
if [ ! -f "build/web/index.html" ]; then
  echo "Error: build/web/index.html was not generated!" >&2
  exit 1
fi

echo "=========================================="
echo "Build complete! Output directory: build/web"
echo "=========================================="
