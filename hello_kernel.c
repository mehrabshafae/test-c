#include <linux/init.h>   // برای ماکروهای __init و __exit
#include <linux/module.h> // برای توابع و ماکروهای ماژول کرنل
#include <linux/kernel.h>  // برای تابع printk

// تابعی که هنگام بارگذاری ماژول اجرا می‌شود
static int __init hello_init(void) {
    printk(KERN_INFO "Hello, Kernel World!\n"); // چاپ در لاگ کرنل
    return 0; // بازگشت ۰ نشان‌دهنده موفقیت‌آمیز بودن است
}

// تابعی که هنگام حذف ماژول اجرا می‌شود
static void __exit hello_exit(void) {
    printk(KERN_INFO "Goodbye, Kernel World!\n");
}

// ثبت توابع init و exit
module_init(hello_init);
module_exit(hello_exit);

// توضیحات ماژول
MODULE_LICENSE("GPL"); // اجازه‌نامه (الزامی)
MODULE_AUTHOR("Your Name"); // نام نویسنده
MODULE_DESCRIPTION("A simple Hello World kernel module"); // شرح ماژول