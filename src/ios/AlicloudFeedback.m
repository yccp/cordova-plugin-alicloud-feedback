#import "AlicloudFeedback.h"

@implementation AlicloudFeedback

- (YWFeedbackKit *)feedbackKit {
    if (!_feedbackKit) {
        NSString *appKey = [[self.commandDelegate settings] objectForKey:@"app_key"];
        NSString *appSecret = [[self.commandDelegate settings] objectForKey:@"app_secret"];
        _feedbackKit = [[YWFeedbackKit alloc] initWithAppKey:appKey appSecret:appSecret];
    }
    return _feedbackKit;
}

- (void)fetchUnreadCount:(CDVInvokedUrlCommand *)command {
    __weak __typeof__(self) weakSelf = self;
    [self.feedbackKit getUnreadCountWithCompletionBlock:^(NSInteger unreadCount, NSError *error) {
        if (error == nil) {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsNSInteger:unreadCount];
            [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:error.userInfo];
            [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

- (void)open:(CDVInvokedUrlCommand *)command
{
    NSError* jsonError;
    NSString* arguments = [command argumentAtIndex:0];
    NSData* objectData = [arguments dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* options = [NSJSONSerialization JSONObjectWithData:objectData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&jsonError];
    self.feedbackKit.extInfo = options;
    __weak __typeof__(self) weakSelf = self;

    
    [self.feedbackKit makeFeedbackViewControllerWithCompletionBlock:^(YWFeedbackViewController *viewController, NSError *error) {
        if (viewController != nil) {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
            CATransition *openAnimation = [CATransition animation];
            [openAnimation setDuration:0.5];
            [openAnimation setType: kCATransitionPush];
            [openAnimation setSubtype:kCATransitionFromRight];
            [openAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
            [weakSelf.viewController presentViewController:nav animated:NO completion:nil];
            [weakSelf.viewController.view.window.layer addAnimation:openAnimation forKey:nil];
            
            CATransition *closeAnimation = [CATransition animation];
            [closeAnimation setDuration:0.5];
            [closeAnimation setType: kCATransitionPush];
            [closeAnimation setSubtype:kCATransitionFromLeft];
            [closeAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
            [viewController setCloseBlock:^(UIViewController *aParentController){
                [aParentController dismissViewControllerAnimated:NO completion:nil];
                [aParentController.view.window.layer addAnimation:closeAnimation forKey:nil];
            }];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:error.userInfo];
            [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

@end