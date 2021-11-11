if [ `expr length "$1"` == 0 ]; then
    echo "Missing directory!"
    exit 0
fi

if [ `expr length "$2"` == 0 ]; then
    echo "Missing file name!"
    exit 0
fi


cd "$1"
asm="$2.asm"
bin="../bin/$2.bin"
echo "Make $asm"
mkdir -p bin
nasm -f bin "$asm" -o "$bin"
qemu-system-x86_64 "$bin"
