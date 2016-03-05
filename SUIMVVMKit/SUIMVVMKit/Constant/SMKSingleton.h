// .h文件
#define SMKSingletonH(name) + (instancetype)shared##name;

// .m文件
#if __has_feature(objc_arc)

    #define SMKSingletonM(name) \
    static id _instace; \
 \
    + (id)allocWithZone:(struct _NSZone *)zone \
    { \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{ \
            _instace = [super allocWithZone:zone]; \
        }); \
        return _instace; \
    } \
 \
    + (instancetype)shared##name \
    { \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{ \
            _instace = [[self alloc] init]; \
        }); \
        return _instace; \
    } \
 \
    - (id)copyWithZone:(NSZone *)zone \
    { \
        return _instace; \
    }

#else

    #define SMKSingletonM(name) \
    static id _instace; \
 \
    + (id)allocWithZone:(struct _NSZone *)zone \
    { \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{ \
            _instace = [super allocWithZone:zone]; \
        }); \
        return _instace; \
    } \
 \
    + (instancetype)shared##name \
    { \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{ \
            _instace = [[self alloc] init]; \
        }); \
        return _instace; \
    } \
 \
    - (id)copyWithZone:(NSZone *)zone \
    { \
        return _instace; \
    } \
 \
    - (oneway void)release { } \
    - (id)retain { return self; } \
    - (NSUInteger)retainCount { return 1;} \
    - (id)autorelease { return self;}

#endif