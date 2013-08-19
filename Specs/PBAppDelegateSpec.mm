#import "PBAppDelegate.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(PBAppDelegateSpec)

describe(@"PBAppDelegate", ^{
    __block PBAppDelegate *delegate;

    beforeEach(^{
        delegate = [[[PBAppDelegate alloc] init] autorelease];
        [delegate application:nil didFinishLaunchingWithOptions:nil];
    });

    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        context(@"when on iPad", ^{
            it(@"should use a UISplitViewController", ^{
                [[delegate window] rootViewController] should be_instance_of([UISplitViewController class]);
            });
        });
    } else {
        context(@"when on iPhone", ^{
            it(@"should use a UINavigationController", ^{
                [[delegate window] rootViewController] should be_instance_of([UINavigationController class]);
            });
        });
    }
});

SPEC_END
