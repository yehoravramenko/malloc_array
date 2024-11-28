#include "malloc_array.h"

void *array_pool = (void *)0;

typedef struct MallocArray {
  void *start;
  size_t element_size;
  int length;
} MallocArray;

MallocArray CALL *MallocArray_Init() {}