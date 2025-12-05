# 1. Set the new version
VERSION="0.1.55a"

# 2. Define the files (matches your logic)
declare -A FILES
FILES["x86_64-linux"]="glide.linux-x86_64.tar.xz"
FILES["aarch64-linux"]="glide.linux-aarch64.tar.xz"
FILES["x86_64-darwin"]="glide.macos-x86_64.dmg"
FILES["aarch64-darwin"]="glide.macos-aarch64.dmg"

# 3. Loop through, download, and print the Nix-formatted hash
for SYSTEM in "${!FILES[@]}"; do
  URL="https://github.com/glide-browser/glide/releases/download/${VERSION}/${FILES[$SYSTEM]}"
  
  echo "Downloading for $SYSTEM..."
  # --type sha256 is default, but explicit is good
  HASH=$(nix-prefetch-url "$URL" --type sha256)
  
  echo "Result for $SYSTEM:"
  echo "sha256 = \"$HASH\";"
  echo "--------------------------------"
done
