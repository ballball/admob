/*
 * iphone-specific implementation of the admob extension.
 * Add any platform-specific functionality here.
 */
/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */
#include "admob_internal.h"
#include "s3eEdk_iphone.h"
#include "s3eDebug.h"
#include "GADBannerView.h"
#import "GADBannerViewDelegate.h"
#include "stdio.h"










@interface gadDelegate : NSObject <GADBannerViewDelegate> {
}

@end


@implementation gadDelegate

  - (void)adViewDidReceiveAd:(GADBannerView *)bannerView
  {
       s3eDebugOutputString("adViewDidReceiveAd");
  }
  - (void)adView:(GADBannerView *)bannerView
      didFailToReceiveAdWithError:(GADRequestError *)error
  {
      s3eDebugOutputString("adView didFailToReceiveAdWithError");
      const char * s1;
      s1 = [[error localizedDescription] UTF8String];
      s3eDebugOutputString(s1);
      s1 = [[error localizedFailureReason] UTF8String];
      s3eDebugOutputString(s1);
      s1 = [[error localizedRecoverySuggestion] UTF8String];
      s3eDebugOutputString(s1);
      //s1 = [[error ] UTF8String];
      //s3eDebugOutputString(s1);
  }

  - (void)adViewWillPresentScreen:(GADBannerView *)bannerView
  {
       s3eDebugOutputString("adViewWillPresentScreen");
  }
  - (void)adViewDidDismissScreen:(GADBannerView *)bannerView
  {
       s3eDebugOutputString("adViewDidDismissScreen");
  }
  - (void)adViewWillLeaveApplication:(GADBannerView *)bannerView
  {
       s3eDebugOutputString("adViewWillLeaveApplication");
  }

@end










struct admob_Global{
       GADBannerView * bview;
       CGSize size;
       gadDelegate * delegate;
       void init(){
         bview = 0;
         delegate = nil;
       }
       void term(){
          if(bview)
            [bview dealloc];
          if(delegate)
            [delegate dealloc];
       }
} admob_Global_;



s3eResult admobInit_platform()
{
    s3eDebugOutputString("admobInit_platform()");
    admob_Global_.init();
    return S3E_RESULT_SUCCESS;
}

void admobTerminate_platform()
{
    s3eDebugOutputString("admobTerminate_platform");
    admob_Global_.term();
}

s3eResult admob_init_platform(const char* pub_id, int ad_type, int orientation, int x, int y)
{
    s3eDebugOutputString("admob_init_platform");
    NSString * sPubId = [NSString stringWithUTF8String:pub_id];

    //s3eEdkGetUIView();
    //CGRect rect = CGRectMake(0,0,320,50);

    CGRect screenRect = [[UIScreen mainScreen] bounds];

//    CGRect rect = CGRectMake(screenRect.size.width - GAD_SIZE_728x90.height, 0, GAD_SIZE_728x90.height, GAD_SIZE_728x90.width);

    CGSize size;

    if(ad_type == Admob_GAD_SIZE_320x50)
      size = GAD_SIZE_320x50;
    else if(ad_type == Admob_GAD_SIZE_300x250)
      size = GAD_SIZE_300x250;
    else if(ad_type == Admob_GAD_SIZE_468x60)
      size = GAD_SIZE_468x60;
    else if(ad_type == Admob_GAD_SIZE_728x90)
      size = GAD_SIZE_728x90;

    else
     return S3E_RESULT_ERROR;

    admob_Global_.size = size;

    CGRect rect = CGRectMake(0, 0, size.width, size.height);

    admob_Global_.delegate = [[gadDelegate alloc] init];

    admob_Global_.bview = [[[GADBannerView alloc] initWithFrame:rect] autorelease];
    admob_Global_.bview.delegate = admob_Global_.delegate;
    //bview.center = CGPointZero;
    admob_Global_.bview.adUnitID = sPubId;
    admob_Global_.bview.rootViewController = s3eEdkGetUIViewController();
    //[s3eEdkGetUIView() addSubview:bview];
    [s3eEdkGetUIWindow() addSubview:admob_Global_.bview];

    admob_Global_.bview.hidden = NO;

    admob_refresh_platform();
    admob_move_platform(orientation, x, y);

    return S3E_RESULT_SUCCESS;
}
s3eResult admob_resize_platform(int ad_type)
{
    s3eDebugOutputString("admob_resize_platform");
    CGSize size;

    if(ad_type == Admob_GAD_SIZE_320x50)
      size = GAD_SIZE_320x50;
    else if(ad_type == Admob_GAD_SIZE_300x250)
      size = GAD_SIZE_300x250;
    else if(ad_type == Admob_GAD_SIZE_468x60)
      size = GAD_SIZE_468x60;
    else if(ad_type == Admob_GAD_SIZE_728x90)
      size = GAD_SIZE_728x90;

    else
     return S3E_RESULT_ERROR;

    admob_Global_.size = size;

    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    admob_Global_.bview.frame = rect;
    return S3E_RESULT_SUCCESS;
}
s3eResult admob_show_platform()
{
    s3eDebugOutputString("admob_show_platform");
    admob_Global_.bview.hidden = NO;
    return S3E_RESULT_SUCCESS;
}

s3eResult admob_refresh_platform()
{
    s3eDebugOutputString("admob_refresh_platform");

    GADRequest *request = [GADRequest request];

    //request.testDevices = [NSArray arrayWithObjects:
    //    GAD_SIMULATOR_ID,                               // Simulator
    //    @"28ab37c3902621dd572509110745071f0101b124",    // Test iPhone 3G 3.0.1
    //    @"8cf09e81ef3ec5418c3450f7954e0e95db8ab200",    // Test iPod 4.3.1
    //    nil];

    [admob_Global_.bview loadRequest:request];
    //[admob_Global_.bview loadRequest:[GADRequest request]];
    return S3E_RESULT_SUCCESS;
}

s3eResult admob_hide_platform()
{
    s3eDebugOutputString("admob_hide_platform");
    admob_Global_.bview.hidden = YES;
    return S3E_RESULT_SUCCESS;
}

s3eResult admob_move_platform(int orientation, int x, int y)
{
    s3eDebugOutputString("admob_move_platform");
    // admob_Orientation_Portrait  = 0,
    // admob_GAD_SIZE_Landscape = 1,
    // admob_GAD_SIZE_PortraitDown  = 2,
    // admob_GAD_SIZE_LandscapeDown  = 3,


  CGRect screenRect = [[UIScreen mainScreen] bounds];

  admob_Global_.bview.transform = CGAffineTransformMakeRotation(M_PI * orientation / 2.0);
  //admob_Global_.bview.center = CGPointMake(admob_Global_.size.width / 2 + x, admob_Global_.size.height / 2 + y);
  //admob_Global_.bview.center = CGPointMake(admob_Global_.size.width / 2 + x, admob_Global_.size.height / 2 + y);
  //admob_Global_.bview.center = CGPointMake(screenRect.size.width / 2 + x, screenRect.size.height / 2 + y);
  //return S3E_RESULT_SUCCESS;

  int x1 = admob_Global_.size.width / 2 + x;
  int y1 = admob_Global_.size.height / 2 + y;

  if(orientation == Admob_Orientation_Portrait){
    admob_Global_.bview.center = CGPointMake(x1, y1);
  } else   if(orientation == Admob_GAD_SIZE_Landscape){
    admob_Global_.bview.center = CGPointMake(screenRect.size.width - y1, x1);
  } else   if(orientation == Admob_GAD_SIZE_PortraitDown){
    admob_Global_.bview.center = CGPointMake(screenRect.size.width - x1, screenRect.size.height - y1);
  } else   if(orientation == Admob_GAD_SIZE_LandscapeDown){
    admob_Global_.bview.center = CGPointMake(y1, screenRect.size.height - x1);
  } else{
    return S3E_RESULT_ERROR;
  }
  //admob_Global_.bview.center = CGPointMake(admob_Global_.size.width / 2 + x, admob_Global_.size.height / 2 + y);
//  admob_Global_.bview.center = CGPointMake(x, y);
    return S3E_RESULT_SUCCESS;
}
