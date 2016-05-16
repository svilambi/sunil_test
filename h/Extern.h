#ifdef WIN32

#ifdef BUILDING_ICTSEOSADDITIONS
#define ICTSEOSADDITIONS_EXTERN __declspec(dllexport) extern
#else
#define ICTSEOSADDITIONS_EXTERN __declspec(dllimport) extern
#endif

#else

#define ICTSEOSADDITIONS_EXTERN extern

#endif
