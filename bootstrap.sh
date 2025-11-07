#!/usr/bin/env bash
set -e

echo "➡️  Sincronizando dotfiles com links simbólicos..."

CONFIGS="$HOME/.felomenal/configs"

declare -A LINKS=(
  [".zshrc"]="$CONFIGS/zshrc"
  [".gitconfig"]="$CONFIGS/gitconfig"
  [".aliases"]="$CONFIGS/aliases"
  [".config/nvim/init.lua"]="$CONFIGS/nvim/init.lua"
)

for TARGET in "${!LINKS[@]}"; do
  SRC="${LINKS[$TARGET]}"
  DEST="$HOME/$TARGET"

  mkdir -p "$(dirname "$DEST")"

  # Se já existir, cria backup
  if [ -e "$DEST" ] && [ ! -L "$DEST" ]; then
    mv "$DEST" "$DEST.backup.$(date +%s)"
    echo "🔁 Backup criado: $DEST.backup"
  fi

  ln -sf "$SRC" "$DEST"
  echo "✅ Link criado: $DEST → $SRC"
done

echo "🎯 Sincronização concluída!"
