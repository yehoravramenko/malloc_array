#define MALLOC_ARRAY_EXPORTS
#include "malloc_array.h"
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

MallocArray *array_pool = (void *)0;
int array_pool_count = 0;

#ifdef DEBUG
#define DBG_MSG(...) printf(__VA_ARGS__)
#else
#define DBG_MSG(...)
#endif

void CALL ArrayPool_Push(MallocArray array) {
  void *temp = realloc(array_pool, (++array_pool_count) * sizeof(MallocArray));
  if (temp == NULL) {
    exit(-1);
  }
  array_pool = (MallocArray *)temp;
  array_pool[array_pool_count - 1] = array;
  // DBG_MSG("address is 0x%08" PRIxPTR "\n",
  //         (uintptr_t)(array_pool[array_pool_count - 1]));
}

void CALL MallocArray_Clean() {
  for (int i = 0; i < array_pool_count; i++) {
    free(array_pool[i]->address);
    DBG_MSG("[%d] Malloc array at 0x%08" PRIxPTR " was cleaned\n", i,
            (uintptr_t)(array_pool[i]->address));
    free(array_pool[i]);
    DBG_MSG("[%d] Malloc array struct at 0x%08" PRIxPTR " was cleaned\n", i,
            (uintptr_t)(array_pool[i]));
  }
}

MallocArray CALL MallocArray_Init() {
  MallocArray array = calloc(1, sizeof(_MallocArray));
  array->address = realloc(array->address, sizeof(void *));
  ArrayPool_Push(array);
  return array;
}