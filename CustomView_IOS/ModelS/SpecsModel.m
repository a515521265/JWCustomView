//
//  SpecsModel.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/11/8.
//
//

#import "SpecsModel.h"

@implementation SpecsModel

@end


@implementation LayoutModel

-(void)setPid:(NSInteger)pid{

    _pid = pid;
    
    switch (_pid) {
        case 1:
            self.clasStr = @"PDTSimpleCalendarViewController";
            break;
        case 2:
            self.clasStr = @"JPSImagePickerController";
            break;
        case 3:
            self.clasStr = @"KeyboardDemoViewController";
            break;
        case 4:
            self.clasStr = @"CustomLabelDemoViewController";
            break;
        case 5:
            self.clasStr = @"WebViewDemoViewController";
            break;
        case 6:
            self.clasStr = @"XYPieChartDemoViewController";
            break;
        case 7:
            self.clasStr = @"SearchBankDemoViewController";
            break;
        case 8:
            self.clasStr = @"CustomProgressDemoViewController";
            break;
        case 9:
            self.clasStr = @"LocalCheckBankDemoViewController";
            break;
        case 10:
            self.clasStr = @"SavePermanentDemoViewController";
            break;
        case 11:
            self.clasStr = @"CustomSwitchDemoViewController";
            break;
        case 12:
            self.clasStr = @"MonitorScreenshotDemoViewController";
            break;
        default:
            self.clasStr = [NSString stringWithFormat:@"ID:%ld,未定义class",(long)_pid];
            break;
    }
    
    
    
}

@end
