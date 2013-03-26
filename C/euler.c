#include <stdio.h>
#include <stdlib.h>

int eu1() {
  int total = 0;
  int i;
  for(i = 0; i < 1000; i++) {
    if (i % 3 == 0 || i % 5 == 0) total += i;
  }
  return total;
}

int eu2() {
  int a = 1;
  int b = 2;
  int total = 0;
  while ( b < 4000000) {
    if (b % 2 == 0) total += b;
    b = a + b;
    a = b - a;
  }
  return total;
}

int eu3() {
  long num = 600851475143;
  int factor = 2;
  while ( factor < num ) {
    factor++;
    if ( num % factor == 0 ) num = num / factor;
  }
  return factor;
}


int main() {
  printf("Euler 1: %d\n", eu1());
  printf("Euler 2: %d\n", eu2());
  printf("Euler 3: %d\n", eu3());

  return 0;
}

