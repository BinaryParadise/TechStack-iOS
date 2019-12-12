#include "stdio.h"

int main() {
	__block int a = 10;
	void (^myBlock)(void) = ^{
		a++;
		printf("Hello World! a=%d\n", a);
	};
	myBlock();

	return 0;
}
