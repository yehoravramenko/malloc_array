#define MALLOC_ARRAY_EXPORTS
#include "malloc_array.h"
#include <stdlib.h>
#include <stdio.h>

MallocArray *array_pool = (void *)0;
int array_pool_count = 0;

void CALL ArrayPool_Push(MallocArray array) {
  void *temp = realloc(array_pool, (++array_pool_count) * sizeof(MallocArray));
  if (temp == NULL) {
    exit(-1);
  }
  array_pool = (MallocArray *)temp;
  array_pool[array_pool_count - 1] = array;
  printf("address is %p\n", array_pool[array_pool_count - 1]);
}

MallocArray CALL MallocArray_Init() {
  MallocArray array = calloc(1, sizeof(_MallocArray));
  array->address = realloc(array->address, sizeof(void *));
  ArrayPool_Push(array);
  return array;
}