CONFIG_FILE="$HOME/.config/hyprpaper.conf"

if [ -z "$1" ]; then
    echo "Supply the wallpaper gng!"
    exit 1
fi

hyprctl hyprpaper wallpaper ",$1"

cat << EOF > CONFIG_FILE
wallpaper {
    monitor =
    path = $1
}

splash=false
EOF

matugen image --prefer darkness -m dark $1