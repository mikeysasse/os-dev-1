if [ `expr length "$1"` == 0 ]; then
    echo "Missing directory!"
    exit 0
fi

if [ `expr length "$2"` == 0 ]; then
    echo "Missing file name!"
    exit 0
fi

cd "$1"
i686-elf-gcc -ffreestanding -c $2.c -o $2.o
echo "Made $2.o"