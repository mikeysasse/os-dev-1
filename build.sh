len=`expr length "$1"`
if [ $len == 0 ]; then
    echo "Missing file name!"
else
    asm="$1.asm"
    bin="./bin/$1.bin"
    echo "Make $asm"
    mkdir -p bin
    nasm -f bin "$asm" -o "$bin"
    qemu-system-x86_64 "$bin"
fi