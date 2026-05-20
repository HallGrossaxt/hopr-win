#ifdef _WIN32
/* On Windows the stack size is managed by the PE header / linker flags.
   There is no POSIX setrlimit, so this is a no-op. */
void setstacksizeunlimited(void) { }
#else
#include <sys/resource.h>

void setstacksizeunlimited(void)
{
   struct rlimit limit;
   getrlimit(RLIMIT_STACK, &limit);

   limit.rlim_cur=limit.rlim_max;

   setrlimit(RLIMIT_STACK, &limit);
}
#endif
