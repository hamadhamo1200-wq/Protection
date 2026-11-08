#import <Foundation/Foundation.h>
#import <substrate.h>
#import <sys/stat.h>
#import <string.h>
#import <dlfcn.h>

// 1. تجاوز فحص الملفات (Jailbreak Detection Bypass)
static int (*orig_stat)(const char *path, struct stat *buf);
static int hook_stat(const char *path, struct stat *buf) {
    if (path && (strstr(path, "Cydia") || strstr(path, "Sileo") || strstr(path, "var/jb") || strstr(path, "MobileSubstrate") || strstr(path, "substrate") || strstr(path, "Crackbydipper") || strstr(path, "EreenModz"))) {
        return -1; 
    }
    return orig_stat(path, buf);
}

static int (*orig_access)(const char *path, int amode);
static int hook_access(const char *path, int amode) {
    if (path && (strstr(path, "/var/jb") || strstr(path, "/Library/MobileSubstrate") || strstr(path, "Crackbydipper") || strstr(path, "EreenModz"))) {
        return -1;
    }
    return orig_access(path, amode);
}

__attribute__((constructor))
static void init_protection() {
    MSHookFunction((void *)&stat, (void *)&hook_stat, (void **)&orig_stat);
    MSHookFunction((void *)&access, (void *)&hook_access, (void **)&orig_access);
}
