#ifdef MALLOC_ARRAY_EXPORTS
#define MALLOC_ARRAY_API __declspec(dllexport)
#else
#define MALLOC_ARRAY_API __declspec(dllimport)
#endif

#define CALL __cdecl

#include "stddef.h"

typedef struct _MallocArray {
  void *address;
  size_t element_size;
  int length;
} _MallocArray;
typedef _MallocArray *MallocArray;

MALLOC_ARRAY_API void CALL ArrayPool_Push(MallocArray array);

MALLOC_ARRAY_API MallocArray CALL MallocArray_Init();
MALLOC_ARRAY_API void CALL MallocArray_Clean();