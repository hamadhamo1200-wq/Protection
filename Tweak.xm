#import <Foundation/Foundation.h>
#import <substrate.h>

static int (*orig_access)(const char *path, int amode);

static int hook_access(const char *path, int amode) {
    if (path != NULL) {
        if (strstr(path, "Cydia") != NULL || 
            strstr(path, "Sileo") != NULL || 
            strstr(path, "var/jb") != NULL || 
            strstr(path, "Crackbydipper") != NULL || 
            strstr(path, "EreenModz") != NULL) {
            return -1; 
        }
    }
    return orig_access(path, amode);
}

%ctor {
    MSHookFunction((void *)&access, (void *)&hook_access, (void **)&orig_access);
}
