#import "BeeKeycode.h"

@interface BeeKeyboard
//addonName: your addon name. if your bundle name is Basic.bundle, "Basic" is your addon name.
//Table: defaults entry in Setting info file without "BeeKeyboard/".
//      ex, defaults - "BeeKeyboard/Basic" ====> Table:@"Basic"
//Global: if global mode => YES, if app(default) mode => NO


//event: key entry in Setting info file.
//return: @"usagePage.modStat.keyCode"
+(NSString *)keyFromEvent:(NSString *)event AddonName:(NSString *)addonName Global:(BOOL)global;

//return: key entry in Setting info file.
+(NSString *)eventFromKeyCode:(int)keyCode Mod:(int)modStat UsagePage:(int)uP AddonName:(NSString *)addonName Table:(NSString *)table Global:(BOOL)global;
//keyString: [NSString stringWithFormat:@"7.%d.%d", modStat, keyCode]
+(NSString *)eventFromKey:(NSString *)keyString AddonName:(NSString *)addonName Table:(NSString *)table Global:(BOOL)global;

@end
