#import <UIKit/UIKit.h>
// http://api.iolate.kr/beekeyboard/info/
// https://github.com/iolate/BeeKeyboard-Addons/
// http://api.iolate.kr/beekeyboard/headers/
#import "BeeKeyboard.h"

#import "forSafari/header.h"


#define DRAG_VALUE		120
#define DRAG_DELAY		0.2f

BOOL isLeftArrowKeyDown = NO;
BOOL isRightArrowKeyDown = NO;
BOOL isUpArrowKeyDown = NO;
BOOL isDownArrowKeyDown = NO;


// http://api.iolate.kr/beekeyboard/info/
// return
//	0 : send event to next responder
//	1 : not send to any responder
//	2 : send to system only
int keyEvent(int keyCode, int modStat, BOOL keyDown)
{
	NSString *event = [objc_getClass("BeeKeyboard") eventFromKeyCode:keyCode 
																 Mod:modStat 
														   UsagePage:7 
														   AddonName:@ADDON_NAME 
															   Table:[@ADDON_NAME lowercaseString] 
															  Global:NO];
	
	if (keyDown) {
		if ([event isEqualToString:@"LeftScroll"]) {
			// scroll
			if (isLeftArrowKeyDown == NO) {
				isLeftArrowKeyDown = YES;
				dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
					while (isLeftArrowKeyDown) {
						if (!goLeftBydeVbugForSafari(DRAG_VALUE)) break;
						[NSThread sleepForTimeInterval:DRAG_DELAY];
					}
				});
				return 1;
			}
		} else if ([event isEqualToString:@"RightScroll"]) {
			// scroll
			if (isRightArrowKeyDown == NO) {
				isRightArrowKeyDown = YES;
				dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
					while (isRightArrowKeyDown) {
						if (!goRightBydeVbugForSafari(DRAG_VALUE)) break;
						[NSThread sleepForTimeInterval:DRAG_DELAY];
					}
				});
				return 1;
			}
		} else if ([event isEqualToString:@"DownScroll"]) {
			// scroll
			if (isDownArrowKeyDown == NO) {
				isDownArrowKeyDown = YES;
				dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
					while (isDownArrowKeyDown) {
						if (!goDownBydeVbugForSafari(DRAG_VALUE)) break;
						[NSThread sleepForTimeInterval:DRAG_DELAY];
					}
				});
				return 1;
			}
		} else if ([event isEqualToString:@"UpScroll"]) {
			// scroll
			if (isUpArrowKeyDown == NO) {
				isUpArrowKeyDown = YES;
				dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
					while (isUpArrowKeyDown) {
						if (!goUpBydeVbugForSafari(DRAG_VALUE)) break;
						[NSThread sleepForTimeInterval:DRAG_DELAY];
					}
				});
				return 1;
			}
		}
		
		isLeftArrowKeyDown = isRightArrowKeyDown = isDownArrowKeyDown = isUpArrowKeyDown = NO;
		
		if ([event isEqualToString:@"PrevTab"]) {
			// prev tab
			prevTabBydeVbugForSafari();
			return 1;
		} else if ([event isEqualToString:@"NextTab"]) {
			// next tab
			nextTabBydeVbugForSafari();
			return 1;
		}
		
		if ([event isEqualToString:@"GoToBottom"]) {
			// go to bottom
			if (goBottomBydeVbugForSafari())
				return 1;
			return 0;
		} else if ([event isEqualToString:@"GoToTop"]) {
			// go to top
			if (goTopBydeVbugForSafari())
				return 1;
			return 0;
		}
		
		if ([event isEqualToString:@"GoBack"] || [event isEqualToString:@"GoBack2"]) {
			// go back
			if (goBackBydeVbugForSafari())
				return 1;
			return 0;
		} else if ([event isEqualToString:@"GoForward"]) {
			// go forward
			if (goForwardBydeVbugForSafari())
				return 1;
			return 0;
		}
		
		if ([event isEqualToString:@"NewTab"] || [event isEqualToString:@"NewTab2"]) {
			// open new tab
			openNewTabBydeVbugForSafari();
			return 1;
		}
		
		if ([event isEqualToString:@"Reload"] || [event isEqualToString:@"Reload2"]) {
			// reload
			if (reloadBydeVbugForSafari())
				return 1;
			return 0;
		}
		
		if ([event isEqualToString:@"FocusAddressView"] || [event isEqualToString:@"FocusAddressView2"]) {
			// focus to addressview
			focusAddressViewBydeVbugForSafari();
			return 1;
		}
		
		if ([event isEqualToString:@"CloseTab"]) {
			// close current tab
			closeTabBydeVbugForSafari();
			return 1;
		}
		
		if ([event isEqualToString:@"Escape"]) {
			// resign focus addressview / searchview ...
			if (resignFocusToMainViewBydeVbugForSafari())
				return 1;
			return 0;
		}
		
		/*if (keyCode == KEY_Z && 
				(modStat == MOD_CONTROL || modStat == (MOD_CONTROL | MOD_SHIFT))) {
			// reopen recently closed tab
			return 1;
		}*/
		
		if ([event isEqualToString:@"Search"]) {
			// find
			showSearchOnThisPageBydeVbugForSafari();
			return 1;
		}
		
		if ([event isEqualToString:@"NextSearch"]) {
			// next find
			nextSearchOnPageBydeVbugForSafari();
			return 1;
		}
		if ([event isEqualToString:@"PrevSearch"]) {
			// prev find
			prevSearchOnPageBydeVbugForSafari();
			return 1;
		}
		
		if ([event isEqualToString:@"Twitter"]) {
			if (showTweetControllerBydeVbugForSafari())
				return 1;
			return 0;
		}
		if ([event isEqualToString:@"Print"]) {
			if (showPrintPanelBydeVbugForSafari())
				return 1;
			return 0;
		}
		if ([event isEqualToString:@"AddBookmark"]) {
			if (showAddBookmarkBydeVbugForSafari())
				return 1;
			return 0;
		}
		if ([event isEqualToString:@"AddToHomescreen"]) {
			if (showAddToHomeBydeVbugForSafari())
				return 1;
			return 0;
		}
		if ([event isEqualToString:@"AddToReadingList"]) {
			if (addToReadingListBydeVbugForSafari())
				return 1;
			return 0;
		}
		if ([event isEqualToString:@"ShowBookmarks"]) {
			if (showBookmarksBydeVbugForSafari())
				return 1;
			return 0;
		}
	} else {
		if ([event isEqualToString:@"LeftScroll"]) {
			// scroll
			isLeftArrowKeyDown = NO;
		} else if ([event isEqualToString:@"RightScroll"]) {
			// scroll
			isRightArrowKeyDown = NO;
		} else if ([event isEqualToString:@"DownScroll"]) {
			// scroll
			isDownArrowKeyDown = NO;
		} else if ([event isEqualToString:@"UpScroll"]) {
			// scroll
			isUpArrowKeyDown = NO;
		}
	}
	
	return 0;
}
