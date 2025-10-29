#include "main.h"

static int parse_int(char s[]) { // stoi простонародный
  int n = 0;
  int sign = s[0] == '-';
  for (size_t i = sign; s[i] != 0; ++i) {
    if (s[i] < '0' || s[i] > '9') {
      fprintf(stderr, "Failed to parse number, '%c' is not a digit\n", s[i]);
      exit(-1);
    }
    n *= 10;
    n += s[i] - '0';
  }
  return n;
}

int count_divs(int n) {
  if (n < 0)
    return -1;
  if (n == 0)
    return 0;
  int i, divs = 0;
  for (i = 1; i*i < n; ++i) {
    if (n % i == 0)
      divs += 2;
  }
  return divs + (i*i == n);
}

int number_with_divs(int number_of_divs) {
  if (number_of_divs < 0)
    return -1;
  int acc = 0;
  for (int i = 0; count_divs(acc) < number_of_divs; acc += i, ++i);
  return acc;
}

int main(int argc, char* argv[]) {
  int n = DEFAULT_ARG;
  if (argc == 2) {
    n = parse_int(argv[1]);
  }
  if (argc > 2) {
    fprintf(stderr, "Too many arguments! Expected 1 or 0\n");
    fprintf(stderr, "Usage: %s [ <number> ]\n", argv[0]);
    return -1;
  }
  printf("%d\n", number_with_divs(n));
  return 0;
}
