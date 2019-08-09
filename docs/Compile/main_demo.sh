sdkPath=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk
clang main.m -isysroot $sdkPath
echo '预处理&词法分析'
clang -fmodules -fsyntax-only -Xclang -dump-tokens main.m -isysroot $sdkPath
echo '------------------'

echo '语法分析'
clang -fmodules -fsyntax-only -Xclang -ast-dump main.m  -isysroot $sdkPath
echo '------------------'

echo '开始编译'
echo '中间代码IR > o-main1.ll'
clang -fmodules -S -fobjc-arc -emit-llvm main.m -o o-main1.ll -isysroot $sdkPath

echo '编译优化 > o-main2.bc'
clang -emit-llvm -c main.m -o o-main2.bc -isysroot $sdkPath

echo '生成汇编 > o-main3.s'
clang -S -fobjc-arc main.m -o o-main3.s -isysroot $sdkPath

echo '生成目标 > o-main4.o'
clang -fmodules -c main.m -o o-main4.o -isysroot $sdkPath

echo '生成可执行文件 > o-main'
clang o-main4.o -o o-main -isysroot $sdkPath

echo '执行o-main'
./o-main
rm o-main*
