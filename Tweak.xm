#import <Foundation/Foundation.h>
#import <substrate.h>
#import <string.h>

// اعتراض دالة فحص الملفات
static int (*orig_access)(const char *path, int amode);
static int hook_access(const char *path, int amode) {
    // هنخفي بس مسارات الجيلبريك وملفات المودات
    // لو اللعبة بتدور على ملفاتها هي، مش هنلمسها
    if (path && (strstr(path, "Cydia") || strstr(path, "Sileo") || strstr(path, "var/jb") || strstr(path, "MobileSubstrate") || strstr(path, "Crackbydipper") || strstr(path, "EreenModz"))) {
        return -1; // بنقولها الملف مش موجود
    }
    return orig_access(path, amode); // بنسيب اللعبة تفحص ملفاتها عادي
}

__attribute__((constructor))
static void init_protection() {
    MSHookFunction((void *)&access, (void *)&hook_access, (void **)&orig_access);
}
