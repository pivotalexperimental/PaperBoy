#import "PBAppDelegate.h"
#import "PBPublication.h"


@implementation PBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [PBPublication publicationRootViewController];

    [self.window makeKeyAndVisible];
    return YES;
}
@end
