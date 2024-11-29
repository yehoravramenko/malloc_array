#include "../lib/malloc_array.h"
// #include <stdio.h>

int main() {
  MallocArray array = MallocArray_Init();
  // printf("address of mallocArray is 0x%p\n", array);

  MallocArray_Clean();

  return 0;
}