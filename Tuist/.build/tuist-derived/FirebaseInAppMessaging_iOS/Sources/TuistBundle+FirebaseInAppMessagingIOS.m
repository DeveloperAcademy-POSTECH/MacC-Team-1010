#import <Foundation/Foundation.h>
#import "TuistBundle+FirebaseInAppMessaging_iOS.h"

NSBundle* FirebaseInAppMessaging_iOS_SWIFTPM_MODULE_BUNDLE() {
    NSURL *bundleURL = [[[NSBundle mainBundle] bundleURL] URLByAppendingPathComponent:@"Firebase_FirebaseInAppMessaging_iOS.bundle"];

    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];

    return bundle;
}