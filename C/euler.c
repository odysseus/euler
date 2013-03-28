#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <stdbool.h>

// Prototypes
int eu1();
int eu2();
int eu3();
int eu4();
long eu5();
long eu6();
long eu7();
int eu8();
int eu9();
long eu10();
long eu12();
void strrev(char*);
bool isPrime(long);
long fastPrime(long);
int factors(long);

int main() {
  printf("Euler 1:\t%d\n", eu1());
  printf("Euler 2:\t%d\n", eu2());
  printf("Euler 3:\t%d\n", eu3());
  printf("Euler 4:\t%d\n", eu4());
  printf("Euler 5:\t%ld\n", eu5());
  printf("Euler 6:\t%ld\n", eu6());
  printf("Euler 7:\t%ld\n", eu7());
  printf("Euler 8:\t%d\n", eu8());
  printf("Euler 9:\t%d\n", eu9());
  printf("Euler 10:\t%ld\n", eu10());
  printf("Euler 12:\t%ld\n", eu12());

  return 0;
}

int eu1() {
  int total = 0;
  int i;
  for(i = 0; i < 1000; i++) 
  {
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

int eu4() {
  int x;
  int y;
  int z;
  int max = 0;
  char a[7];
  char b[7];

  for(x = 999 ; x > 99 ; x--)
  {
    for(y = 999 ; y > 99 ; y--)
    {
      z = x * y;
      sprintf(a, "%d", z);
      strcpy(b, a);
      strrev(b);
      if(strcmp(a, b) == 0)
      {
        if(z > max)
        {
          max = z;
        }
      }
    }
  }
  return max;
}

long eu5() {
  long candidate = 20;
  bool test = false;
  while (!test) {
    candidate += 20;
    test = true;
    for (int i = 2; i <= 20; ++i)
    {
      if (candidate % i != 0) {
        test = false;
        break;
      }
    }
  }
  return candidate;
}

long eu6() {
  long sumOfSquares = 0;
  long squareOfSums = 0;
  for (int i=1; i <= 100; i++)
  {
    sumOfSquares += (i * i);
    squareOfSums += i;
  }
  return ((squareOfSums * squareOfSums) - sumOfSquares);
}

long eu7() {
  return fastPrime(10001);
}

int eu8() {
  int maxprod = 0;
  int prod;
  char array[1001] = {"7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"};
  for(int i = 0; i <= 995; i++) 
  {
    prod = 1;
    for(int j = 0; j <= 4; j++)
      prod = prod * (array[i+j] - '0');
    if(prod > maxprod)
      maxprod = prod;
  }
  return maxprod;
}

int eu9() {
  int a,b,c;
  for (a=1;a<500;a++)
    for (b=2;b<500;b++) 
    {
     c=1000-a-b;
     if (c>b) {
      if (a*a+b*b==c*c)
        return (a*b*c);
    }
  }
}

long eu10() {
  long total = 0;
  for (int i = 0; i < 2000000; i++)
  {
    if (isPrime(i)) total += i;
  }
  return total;
}

// Euler 11:
// Parsing files and multidimensional arrays is a job for Ruby

long eu12() {
  bool done = false;
  int n = 0;
  long tnum = 0;
  while (!done) 
  {
    n++;
    tnum += n;
    if (factors(tnum) > 500) return tnum;
  }
}

// Helpers

void strrev(char *p)
{
  char *q = p;
  while(q && *q) ++q;
  for(--q; p < q; ++p, --q)
    *p = *p ^ *q,
  *q = *p ^ *q,
  *p = *p ^ *q;
}

bool isPrime(long n) {
  if (n == 1) return false;
  if (n == 2) return true;
  if (n < 4) return true;
  if (n % 2 == 0) return false;
  if (n < 9) return true;
  if (n % 3 == 0) return false;
  long r = (long)pow(n, 0.5);
  for (long i=5; i<=r; i+=6)
  {
    if (n % i == 0) return false;
    if (n % (i+2) == 0) return false;
  }
  return true;
}

long fastPrime(long limit) {
  if (limit == 1) return 2;
  if (limit == 2) return 3;
  long primes = 2;
  long candidate = 3;
  while (primes < limit) {
    candidate += 2;
    if (isPrime(candidate)) primes += 1;
  }
  return candidate;
}

int factors(long n) {
  int count = 2;
  long root = (long) pow(n, 0.5);
  for (long i=2; i <= (root+1); ++i)
  {
    if (n % i == 0) count += 2;
  }
  if ((root * root) == n) count--;
  return count;
}
























