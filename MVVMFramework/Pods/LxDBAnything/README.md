# LxDBAnything
    Tell you the type of any variable! Print log without any format control symbol! Change debug habit thoroughly! 

### Installation
    You only need drag LxDBAnything.h to your project.

### Podfile
    pod 'LxDBAnything', '~> 1.0.0'

### Support
    Minimum support iOS version: iOS 6.0

### Usage

    #import "LxDBAnything.h"

    id obj = self.view;
    LxDBAnyVar(obj);

    CGPoint point = CGPointMake(12.34, 56.78);
    LxDBAnyVar(point);

    CGSize size = CGSizeMake(87.6, 5.43);
    LxDBAnyVar(size);

    CGRect rect = CGRectMake(2.3, 4.5, 5.6, 7.8);
    LxDBAnyVar(rect);

    NSRange range = NSMakeRange(3, 56);
    LxDBAnyVar(range);

    CGAffineTransform affineTransform = CGAffineTransformMake(1, 2, 3, 4, 5, 6);
    LxDBAnyVar(affineTransform);

    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(3, 4, 5, 6);
    LxDBAnyVar(edgeInsets);

    SEL sel = @selector(viewDidLoad);
    LxDBAnyVar(sel);

    Class class = [UIBarButtonItem class];
    LxDBAnyVar(class);

    NSInteger i = 231;
    LxDBAnyVar(i);

    CGFloat f = M_E;
    LxDBAnyVar(f);

    BOOL b = YES;
    LxDBAnyVar(b);

    char c = 'S';
    LxDBAnyVar(c);

    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    LxDBAnyVar(colorSpaceRef);

    //  ......

    LxPrintAnything(You can use macro LxPrintAnything() print any without quotation as you want!);

    LxPrintf(@"Print format string you customed: %@", LxBox(affineTransform));

    NSLog(@"Even use general NSLog function to print: %@", LxBox(edgeInsets));

    LxPrintf(@"The type of obj is %@", LxTypeStringOfVar(obj));
    LxPrintf(@"The type of point is %@", LxTypeStringOfVar(point));
    LxPrintf(@"The type of size is %@", LxTypeStringOfVar(size));
    LxPrintf(@"The type of rect is %@", LxTypeStringOfVar(rect));
    LxPrintf(@"The type of range is %@", LxTypeStringOfVar(range));
    LxPrintf(@"The type of affineTransform is %@", LxTypeStringOfVar(affineTransform));
    LxPrintf(@"The type of edgeInsets is %@", LxTypeStringOfVar(edgeInsets));
    LxPrintf(@"The type of class is %@", LxTypeStringOfVar(class));
    LxPrintf(@"The type of i is %@", LxTypeStringOfVar(i));
    LxPrintf(@"The type of f is %@", LxTypeStringOfVar(f));
    LxPrintf(@"The type of b is %@", LxTypeStringOfVar(b));
    LxPrintf(@"The type of c is %@", LxTypeStringOfVar(c));
    LxPrintf(@"The type of colorSpaceRef is %@", LxTypeStringOfVar(colorSpaceRef));

    //  ......

    TestModel * testModel = [[TestModel alloc]init];
    testModel.array = @[@1, @"fewfwe", @{@21423.654:@[@"fgewgweg", [UIView new]]}, @YES];
    testModel.dictionary = @{@YES:@[[UITableViewCell new], @"fgewgweg", @-543.64]};
    testModel.set = [NSSet setWithObjects:@NO, @4.325, @{@"fgewgweg":[UIView new]}, nil];
    testModel.orderSet = [NSOrderedSet orderedSetWithObjects:@{@21423.654:@[@"fgewgweg", [UIView new]]}, @1, @"fewfwe", @YES, nil];

    LxDBObjectAsJson(testModel);
    LxDBObjectAsXml(testModel);

    // Run your application and you'll see:

    📍-[ViewController viewDidLoad] + 24🎈 obj = <UIView: 0x7ff8ba711fb0; frame = (0 0; 414 736); autoresize = W+H; layer = <CALayer: 0x7ff8ba710da0>>
    📍-[ViewController viewDidLoad] + 27🎈 point = NSPoint: {12.34, 56.780000000000001}
    📍-[ViewController viewDidLoad] + 30🎈 size = NSSize: {87.599999999999994, 5.4299999999999997}
    📍-[ViewController viewDidLoad] + 33🎈 rect = NSRect: {{2.2999999999999998, 4.5}, {5.5999999999999996, 7.7999999999999998}}
    📍-[ViewController viewDidLoad] + 36🎈 range = NSRange: {3, 56}
    📍-[ViewController viewDidLoad] + 39🎈 affineTransform = CGAffineTransform: {{1, 2, 3, 4}, {5, 6}}
    📍-[ViewController viewDidLoad] + 42🎈 edgeInsets = UIEdgeInsets: {3, 4, 5, 6}
    📍-[ViewController viewDidLoad] + 45🎈 sel = viewDidLoad
    📍-[ViewController viewDidLoad] + 48🎈 class = UIBarButtonItem
    📍-[ViewController viewDidLoad] + 51🎈 i = 231
    📍-[ViewController viewDidLoad] + 54🎈 f = 2.718281828459045
    📍-[ViewController viewDidLoad] + 57🎈 b = YES
    📍-[ViewController viewDidLoad] + 60🎈 c = S
    📍-[ViewController viewDidLoad] + 63🎈 colorSpaceRef = 0x7ff8ba706da0
    📍-[ViewController viewDidLoad] + 67🎈 You can use macro LxPrintAnything() print any without quotation as you want!
    📍-[ViewController viewDidLoad] + 69🎈 Print format string you customed: CGAffineTransform: {{1, 2, 3, 4}, {5, 6}}
    2015-11-23 15:40:25.639 LxDBAnythingDemo[12699:198689] Even use normal NSLog function to print: UIEdgeInsets: {3, 4, 5, 6}
    📍-[ViewController viewDidLoad] + 73🎈 The type of obj is UIView
    📍-[ViewController viewDidLoad] + 74🎈 The type of point is CGPoint
    📍-[ViewController viewDidLoad] + 75🎈 The type of size is CGSize
    📍-[ViewController viewDidLoad] + 76🎈 The type of rect is CGRect
    📍-[ViewController viewDidLoad] + 77🎈 The type of range is NSRange
    📍-[ViewController viewDidLoad] + 78🎈 The type of affineTransform is CGAffineTransform
    📍-[ViewController viewDidLoad] + 79🎈 The type of edgeInsets is LxEdgeInsets
    📍-[ViewController viewDidLoad] + 80🎈 The type of class is Class
    📍-[ViewController viewDidLoad] + 81🎈 The type of i is long
    📍-[ViewController viewDidLoad] + 82🎈 The type of f is double
    📍-[ViewController viewDidLoad] + 83🎈 The type of b is BOOL
    📍-[ViewController viewDidLoad] + 84🎈 The type of c is char
    📍-[ViewController viewDidLoad] + 85🎈 The type of colorSpaceRef is pointer
    📍-[ViewController viewDidLoad] + 95🎈 <TestModel: 0x7ff8ba7113a0> = {
        "affineTransform" : "CGAffineTransform: {{0, 0, 0, 0}, {0, 0}}",
        "orderSet" : [
            {
                "21423.654" : [
                    "fgewgweg",
                    "<UIView: 0x7ff8ba713fc0; frame = (0 0; 0 0); layer = <CALayer: 0x7ff8ba714130>>"
                ]
            },
            "1",
            "fewfwe"
        ],
        "dictionary" : {
            "1" : [
                "<UITableViewCell: 0x7ff8ba7117e0; frame = (0 0; 320 44); layer = <CALayer: 0x7ff8ba711d20>>",
                "fgewgweg",
                "-543.64"
            ]
        },
        "flt" : "0",
        "chr" : "0",
        "size" : "NSSize: {0, 0}",
        "edgeInsets" : "UIEdgeInsets: {0, 0, 0, 0}",
        "set" : [
            "0",
            "4.325",
            {
                "fgewgweg" : "<UIView: 0x7ff8ba713d10; frame = (0 0; 0 0); layer = <CALayer: 0x7ff8ba713e80>>"
            }
        ],
        "bl" : "0",
        "point" : "NSPoint: {0, 0}",
        "array" : [
            "1",
            "fewfwe",
            {
                "21423.654" : [
                    "fgewgweg",
                    "<UIView: 0x7ff8ba7114e0; frame = (0 0; 0 0); layer = <CALayer: 0x7ff8ba70c680>>"
                ]
            },
            "1"
        ],
        "range" : "NSRange: {0, 0}",
        "integer" : "0",
        "rect" : "NSRect: {{0, 0}, {0, 0}}"
    }
    📍-[ViewController viewDidLoad] + 96🎈 <TestModel: 0x7ff8ba7113a0> = <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>affineTransform</key>
        <string>CGAffineTransform: {{0, 0, 0, 0}, {0, 0}}</string>
        <key>array</key>
        <array>
            <string>1</string>
            <string>fewfwe</string>
            <dict>
                <key>21423.654</key>
                <array>
                    <string>fgewgweg</string>
                    <string>&lt;UIView: 0x7ff8ba7114e0; frame = (0 0; 0 0); layer = &lt;CALayer: 0x7ff8ba70c680&gt;&gt;</string>
                </array>
            </dict>
            <string>1</string>
        </array>
        <key>bl</key>
        <string>0</string>
        <key>chr</key>
        <string>0</string>
        <key>dictionary</key>
        <dict>
            <key>1</key>
            <array>
                <string>&lt;UITableViewCell: 0x7ff8ba7117e0; frame = (0 0; 320 44); layer = &lt;CALayer: 0x7ff8ba711d20&gt;&gt;</string>
                <string>fgewgweg</string>
                <string>-543.64</string>
            </array>
        </dict>
        <key>edgeInsets</key>
        <string>UIEdgeInsets: {0, 0, 0, 0}</string>
        <key>flt</key>
        <string>0</string>
        <key>integer</key>
        <string>0</string>
        <key>orderSet</key>
        <array>
            <dict>
                <key>21423.654</key>
                <array>
                    <string>fgewgweg</string>
                    <string>&lt;UIView: 0x7ff8ba713fc0; frame = (0 0; 0 0); layer = &lt;CALayer: 0x7ff8ba714130&gt;&gt;</string>
                </array>
            </dict>
            <string>1</string>
            <string>fewfwe</string>
        </array>
        <key>point</key>
        <string>NSPoint: {0, 0}</string>
        <key>range</key>
        <string>NSRange: {0, 0}</string>
        <key>rect</key>
        <string>NSRect: {{0, 0}, {0, 0}}</string>
        <key>set</key>
        <array>
            <string>0</string>
            <string>4.325</string>
            <dict>
                <key>fgewgweg</key>
                <string>&lt;UIView: 0x7ff8ba713d10; frame = (0 0; 0 0); layer = &lt;CALayer: 0x7ff8ba713e80&gt;&gt;</string>
            </dict>
        </array>
        <key>size</key>
        <string>NSSize: {0, 0}</string>
    </dict>
    </plist>

    📍-[ViewController viewDidAppear:] + 103🎈self.view.window =
    0＃ <UIWindow: 0x7ff8ba4306c0; frame = (0 0; 414 736); autoresize = W+H; gestureRecognizers = <NSArray: 0x7ff8ba431830>; layer = <UIWindowLayer: 0x7ff8ba42cd00>>
    1＃     <UIView: 0x7ff8ba711fb0; frame = (0 0; 414 736); autoresize = W+H; layer = <CALayer: 0x7ff8ba710da0>>
    2＃         <_UILayoutGuide: 0x7ff8ba712380; frame = (0 0; 0 20); hidden = YES; layer = <CALayer: 0x7ff8ba70c660>>
    2＃         <_UILayoutGuide: 0x7ff8ba534d40; frame = (0 736; 0 0); hidden = YES; layer = <CALayer: 0x7ff8ba534ec0>>

    //  Different debug log experience!

### License
    LxDBAnything is available under the MIT License. See the LICENSE file for more info.