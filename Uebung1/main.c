#include <stdio.h>
#include "stack.h"
#include <stdlib.h>

int main() {
    printNumbersGoto(7);
    printf("= printNumbersGoto(7)\n");
    printNumbersFor(7);
    printf("= printNumbersFor(7)\n");
    printNumbersRecursiveFunction(7);
    printf("= printNumbersRecursiveFunction(7)\n");
    return 0;
}/**/
/*int main(int argc, char** argv) {
    stack myStack = init();

     print(myStack);
     top(myStack);
     myStack = push(42, myStack);
     myStack = push(77, myStack);
     myStack = push(1, myStack);
     print(myStack);
     myStack = push(33, myStack);
     myStack = pop(myStack);
     myStack = push(33, myStack);
     print(myStack);
     element e = top(myStack);
     printf("top element is %i\n", e);
     print(myStack);

    printf("size(myStack) = %i\n", size(myStack));
    printf("isEmpty(myStack) = %i\n", isEmpty(myStack));
    print(myStack);
    top(myStack);
    myStack = push(42, myStack);
    myStack = push(77, myStack);
    myStack = push(1, myStack);
    printf("size(myStack) = %i\n", size(myStack));
    printf("isEmpty(myStack) = %i\n", isEmpty(myStack));
    print(myStack);
    return (EXIT_SUCCESS);
}*/

void printNumbersGoto(int n){
    int a = 0;
    next:
    printf("%i ", a);
    a = a + 1;
    if (a<=n) goto next;
}
void printNumbersFor(int n){
    for (int i = 0; i <= n; ++i) {
        printf("%d ", i);
    }
}
void printNumbersRecursiveFunction(int n){
    if (n > 0) printNumbersRecursiveFunction(n-1);

    printf("%i ",n);
}