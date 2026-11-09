#import <Foundation/Foundation.h>
#import <substrate.h>

static int (*orig_access)(const char *path, int amode);
static int hook_access(const char *path, int amode) {
    if (path && (strstr(path, "Cydia") || strstr(path, "Sileo") || strstr(path, "var/jb") || strstr(path, "Crackbydipper") || strstr(path, "EreenModz"))) {
        return -1; 
    }
    return orig_access(path, amode);
}

%ctor {
    MSHookFunction((void *)&access, (void *)&hook_access, (void **)&orig_access);
}
