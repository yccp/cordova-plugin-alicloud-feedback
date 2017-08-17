#import <Cordova/CDVPlugin.h>
#import <YWFeedbackFMWK/YWFeedbackKit.h>
#import <YWFeedbackFMWK/YWFeedbackViewController.h>

@interface AlicloudFeedback : CDVPlugin

@property (nonatomic, strong) YWFeedbackKit *feedbackKit;

- (void)open:(CDVInvokedUrlCommand*)command;
- (void)fetchUnreadCount:(CDVInvokedUrlCommand *)command;

@end