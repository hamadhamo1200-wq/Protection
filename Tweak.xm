#import <Foundation/Foundation.h>
#import <substrate.h>
#import <mach-o/dyld.h>
#import <dlfcn.h>
#import <sys/stat.h>
#import <string.h>

static const char* (*orig_dyld_get_image_name)(uint32_t image_index);
static const char* hook_dyld_get_image_name(uint32_t image_index) {
    const char *name = orig_dyld_get_image_name(image_index);
    if (name && (strstr(name, "Crackbydipper") || strstr(name, "EreenModz") || strstr(name, "substrate") || strstr(name, "ellekit"))) {
        return NULL; 
    }
    return name;
}

static int (*orig_stat)(const char *path, struct stat *buf);
static int hook_stat(const char *path, struct stat *buf) {
    if (path && (strstr(path, "Cydia") || strstr(path, "Sileo") || strstr(path, "var/jb") || strstr(path, "MobileSubstrate"))) {
        return -1; 
    }
    return orig_stat(path, buf);
}

static int (*orig_access)(const char *path, int amode);
static int hook_access(const char *path, int amode) {
    if (path && (strstr(path, "/var/jb") || strstr(path, "/Library/MobileSubstrate"))) {
        return -1;
    }
    return orig_access(path, amode);
}

static int (*orig_ptrace)(int request, pid_t pid, caddr_t addr, int data);
static int hook_ptrace(int request, pid_t pid, caddr_t addr, int data) {
    if (request == 31) { return 0; }
    return orig_ptrace(request, pid, addr, data);
}

__attribute__((constructor))
static void init_protection() {
    MSHookFunction((void *)&_dyld_get_image_name, (void *)&hook_dyld_get_image_name, (void **)&orig_dyld_get_image_name);
    MSHookFunction((void *)&stat, (void *)&hook_stat, (void **)&orig_stat);
    MSHookFunction((void *)&access, (void *)&hook_access, (void **)&orig_access);
    MSHookFunction((void *)&ptrace, (void *)&hook_ptrace, (void **)&orig_ptrace);
}
