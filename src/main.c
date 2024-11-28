#ifdef MALLOC_ARRAY_EXPORTS
#define MALLOC_ARRAY_API __declspec(dllexport)
#else
#define MALLOC_ARRAY_API __declspec(dllimport)
#endif