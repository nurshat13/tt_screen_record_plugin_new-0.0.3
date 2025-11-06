#import "TtScreenRecordPlugin.h"
#import <ReplayKit/ReplayKit.h>

@implementation TtScreenRecordPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
            methodChannelWithName:@"tt_screen_record_plugin"
                  binaryMessenger:[registrar messenger]];
    TtScreenRecordPlugin* instance = [[TtScreenRecordPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:@"start"]) {
        // 开始录制
        [RPScreenRecorder sharedRecorder].delegate = self;

        [RPScreenRecorder sharedRecorder].microphoneEnabled = YES;
        [[RPScreenRecorder sharedRecorder] startRecordingWithHandler:^(NSError *_Nullable error) {
            if (error) {
                result(@{
                               @"success": @(false),
                               @"msg": @"失败",
                       });
            } else {
                result(@{
                               @"success": @(true),
                               @"msg": @"成功",
                       });
            }
        }];
    } else if ([call.method isEqualToString:@"recording"]) {
        // 获取是否正在录制
        result(@([RPScreenRecorder sharedRecorder].recording));
    } else if ([call.method isEqualToString:@"isAvailable"]) {
        // 获取是否支持
        result(@([RPScreenRecorder sharedRecorder].isAvailable));
    } else if ([call.method isEqualToString:@"stop"]) {
        NSString *path;
        if (call.arguments[@"path"]) {
            path = call.arguments[@"path"];
        } else {
            // 获取当前的时间字符串
            NSDate *now = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *currentTimeString = [dateFormatter stringFromDate:now];
            // 如果不传时间戳字符串 就用当前的时间戳字符串作为视频文件名
            NSString *fileName = [NSString stringWithFormat:@"%@.mp4", currentTimeString];
            NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                               NSUserDomainMask,
                                                                               YES) firstObject];
            NSString *dirPath = [documentDirectory stringByAppendingPathComponent:@"tt_record_screen_video"];
            if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
                [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
            path = filePath;
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
            };
        }
        if (@available
        (iOS
        14.0, *)) {
            [[RPScreenRecorder sharedRecorder] stopRecordingWithOutputURL:[NSURL fileURLWithPath:path] completionHandler:^(
                    NSError *_Nullable error) {
                if (error) {
                    result(@{
                                   @"success": @(false),
                                   @"msg": @"失败",
                           });
                } else {
                    result(@{
                                   @"success": @(true),
                                   @"msg": @"成功",
                                   @"path": path
                           });
                }
            }];
        }else{

            [[RPScreenRecorder sharedRecorder] stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {

                if (error) {
                    NSLog(@"结束录屏,出错了: %@",error);
                    result(@{
                                   @"success": @(false),
                                   @"msg": @"失败",
                           });
                }else{
                    result(@{
                                   @"success": @(true),
                                   @"msg": @"成功",
                                   @"path": @""
                           });
                }


            }];

        }

    }
}

@end
