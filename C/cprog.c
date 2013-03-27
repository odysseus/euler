#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Prototypes
void fahrToCels();
void ln();

main () {
  
  // Calling Functions
  fahrToCels();
  ln();

  // Declaring an array of 10 ints
  int digArray[10];

  // Strings
  char *string = "Hello, world!";
  printf("%s\n", string);

}

// Converts Fahrenheit to Celsius from 0F to 300F
void fahrToCels () {
  int fahr;
  for (fahr = 0; fahr <= 300; fahr = fahr + 20)
      printf("%3d %6.1f\n", fahr, (5.0/9.0)*(fahr-32));
}

// Fn for a blank line
void ln () {
  printf("\n");
}