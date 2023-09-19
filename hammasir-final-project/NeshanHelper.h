//
//  NeshanHelper.h
//  hammasir-final-project
//
//  Created by yalda saeedi on 6/28/1402 AP.
//

#ifndef NeshanHelper_h
#define NeshanHelper_h
#import <UIKit/UIKit.h>
#import <NeshanMobileSDK/NeshanMobileSDK.h>

NS_ASSUME_NONNULL_BEGIN

#define API_KEY @"service.fYFAjXz8Ua8BNbkReNJr66AB9qFTYYfdWUNfSnoM"

@interface NeshanHelper: NSObject
+(void) toast:(UIViewController *)parent message:(NSString *)message;
@end

@interface VectorElementClickedListener: NTVectorElementEventListener

typedef BOOL (^OnVectorElementClickedBlock)(NTElementClickData* clickInfo);
@property (readwrite, copy) OnVectorElementClickedBlock onVectorElementClickedBlock;

@end

@interface MapEventListener: NTMapEventListener

typedef void (^OnMapClickedBlock)(NTClickData* clickInfo);
@property (readwrite, copy) OnMapClickedBlock onMapClickedBlock;

typedef void (^OnMapMovedBlock)(void);
@property (readwrite, copy) OnMapMovedBlock onMapMovedBlock;


typedef void (^OnMapStableBlock)(void);
@property (readwrite, copy) OnMapStableBlock onMapStableBlock;


typedef void (^OnMapIdleBlock)(void);
@property (readwrite, copy) OnMapIdleBlock onMapIdleBlock;

@end

NS_ASSUME_NONNULL_END


#endif /* NeshanHelper_h */
