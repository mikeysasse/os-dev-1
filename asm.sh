if [ `expr length "$1"` == 0 ]; then
    echo "Missing directory!"
    exit 0
fi

if [ `expr length "$2"` == 0 ]; then
    echo "Missing file name!"
    exit 0
fi

mkdir -p bin
cd "$1"
asm="$2.asm"
bin="../bin/$2.bin"
echo "Make $asm"
nasm -f bin "$asm" -o "$bin"
qemu-system-x86_64 -nographic "$bin"
