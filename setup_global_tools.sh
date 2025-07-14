#!/bin/bash
set -e

VENV_DIR="/root/.venv"
PIPTOOLS_BIN="/usr/local/bin/piptools"
PYTHONTOOLS_BIN="/usr/local/bin/pytol"

echo "🚀 Mengecek virtualenv di $VENV_DIR..."

if [ ! -f "$VENV_DIR/bin/pip" ]; then
  echo "❌ Venv tidak ditemukan di $VENV_DIR"
  echo "💡 Jalankan dulu: python3 -m venv $VENV_DIR"
  exit 1
fi

echo "✅ Virtualenv ditemukan."

echo "🔧 Membuat wrapper piptools..."
cat << EOF > "$PIPTOOLS_BIN"
#!/bin/bash
$VENV_DIR/bin/pip "\$@"
EOF
chmod +x "$PIPTOOLS_BIN"

echo "🔧 Membuat wrapper pytol..."
cat << EOF > "$PYTHONTOOLS_BIN"
#!/bin/bash
$VENV_DIR/bin/python "\$@"
EOF
chmod +x "$PYTHONTOOLS_BIN"

echo "✅ Wrapper piptools & pytol berhasil dibuat!"
echo
echo "Contoh pemakaian:"
echo "  piptools install -r /LOKASI FOLDER/requirements.txt"
echo "  pytol script.py"

