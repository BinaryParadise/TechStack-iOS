sdkPath=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk
echo '预处理&词法分析'
clang -fmodules -fsyntax-only -Xclang -dump-tokens main.m -isysroot $sdkPath

echo '语法分析'
clang -fmodules -fsyntax-only -Xclang -ast-dump main.m  -isysroot $sdkPath

echo '中间代码IR'
clang -fmodules -S -fobjc-arc -emit-llvm main.m -o main1.ll -isysroot $sdkPath

echo '编译优化'
clang -emit-llvm -c main.m -o main2.bc -isysroot $sdkPath

echo '生成汇编'
clang -S -fobjc-arc main.m -o main3.s -isysroot $sdkPath

echo '生成目标'
clang -fmodules -c main.m -o main4.o -isysroot $sdkPath

echo '生成可执行文件'
clang main4.o -o main -isysroot $sdkPath

echo '执行'
./main
