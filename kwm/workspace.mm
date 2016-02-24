#import "Cocoa/Cocoa.h"
#import "types.h"

extern void UpdateActiveSpace();

@interface MDWorkspaceWatcher : NSObject {
}
- (id)init;
@end

@implementation MDWorkspaceWatcher
- (id)init {
    if ((self = [super init])) {
       [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
                selector:@selector(activeSpaceDidChange:)
                name:NSWorkspaceActiveSpaceDidChangeNotification
                object:nil];
    }
    return self;
}

- (void)dealloc {
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
    [super dealloc];
}
- (void)activeSpaceDidChange:(NSNotification *)notification {
    UpdateActiveSpace();
}
@end

void CreateWorkspaceWatcher(void *Watcher)
{
    MDWorkspaceWatcher *MDWatcher = [[MDWorkspaceWatcher alloc] init];
    Watcher = (void*)MDWatcher;
}

CFStringRef GetDisplayIdentifier(screen_info *Screen)
{
    if(Screen->Identifier)
        return Screen->Identifier;

    CGRect Frame = CGRectMake(Screen->X, Screen->Y, Screen->Width, Screen->Height);
    Screen->Identifier = CGSCopyBestManagedDisplayForRect(CGSDefaultConnection, Frame);
    return Screen->Identifier;
}

int GetActiveSpaceOfDisplay(screen_info *Screen)
{
    int CurrentSpace = -1;
    NSString *CurrentIdentifier = (__bridge NSString *)GetDisplayIdentifier(Screen);

    CFArrayRef ScreenDictionaries = CGSCopyManagedDisplaySpaces(CGSDefaultConnection);
    for (NSDictionary *ScreenDictionary in (__bridge NSArray *)ScreenDictionaries)
    {
        NSString *ScreenIdentifier = ScreenDictionary[@"Display Identifier"];
        if ([ScreenIdentifier isEqualToString:CurrentIdentifier])
        {
            CurrentSpace = [ScreenDictionary[@"Current Space"][@"id64"] intValue];
            break;
        }
    }

    CFRelease(ScreenDictionaries);
    return CurrentSpace;
}