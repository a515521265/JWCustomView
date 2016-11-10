//
//  XLRuntime.h
//  通知
//
//  Created by 田馥甄 on 2016/11/9.
//  Copyright © 2016年 hebe. All rights reserved.
//

#ifndef XLRuntime_h
#define XLRuntime_h


#import <objc/runtime.h>

#define XLMethodSwizzling(methodName, flag...) \
SEL systemSelector##flag = sel_getUid(""#methodName); \
SEL newSelector##flag = sel_getUid("__XL_"#methodName); \
_XLBaseSwizzling(systemSelector##flag, newSelector##flag, flag)


#define XLProtocolSwizzling(protocolName) \
Protocol *protocol##protocolName = objc_getProtocol(""#protocolName); \
if (class_conformsToProtocol(self,protocol##protocolName)) { \
unsigned int outCount = 0; \
struct objc_method_description *methods = protocol_copyMethodDescriptionList(protocol##protocolName, NO, YES, &outCount); \
if (outCount>0) { \
for (int i=0; i<outCount; i++) { \
struct objc_method_description method = methods[i]; \
SEL systemSelector = method.name; \
const char *systemSelName = sel_getName(systemSelector); \
char *headerSelName = "__XL_"; \
char *newSelName  = (char *)malloc(1+strlen(systemSelName)+strlen(headerSelName)); \
strcpy(newSelName, headerSelName); \
strcat(newSelName, systemSelName); \
SEL newSelector = sel_getUid(newSelName); \
_XLBaseSwizzling(systemSelector, newSelector) \
} \
} \
free(methods); \
}

#define XLCategoryProperty_id(setter, getter) \
- (void)setter:(id)sender { \
objc_setAssociatedObject(self, @selector(getter), sender, OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
} \
- (id)getter { \
return objc_getAssociatedObject(self, _cmd); \
}


#define _XLBaseSwizzling(systemSEL, newSEL, flag...) \
Class cls##flag = self.class; \
Method systemMethod##flag = class_getInstanceMethod(cls##flag, systemSEL); \
Method newMethod##flag = class_getInstanceMethod(cls##flag, newSEL); \
if (!systemMethod##flag && !newMethod##flag ) { \
systemMethod##flag = class_getClassMethod(cls##flag, systemSEL); \
newMethod##flag = class_getClassMethod(cls##flag, newSEL); \
cls##flag = object_getClass(self); \
} \
BOOL didAddMethod##flag = class_addMethod(cls##flag, systemSEL, method_getImplementation(newMethod##flag), method_getTypeEncoding(newMethod##flag)); \
if (didAddMethod##flag) { \
class_replaceMethod(cls##flag, newSEL, method_getImplementation(systemMethod##flag), method_getTypeEncoding(systemMethod##flag)); \
} else { \
method_exchangeImplementations(systemMethod##flag, newMethod##flag); \
}


#endif /* XLRuntime_h */
