# ``BlackBox``

Library for logs and measurements.

![BlackBox logo](bb_logo.png)

BlackBox provides convenience ways to log and measure what happens in your app: 
- Events;
- Errors;
- How much time it took to execute some code;
- etc.

Moreover, you can redirect the logs wherever you want. Few destinations are supported out of the box, and you can easily add any other destination by yourself.


For installation tips, see <doc:Installation>

## Writing logs
Log debug message:
```swift
BlackBox.debug("Hello world")
```

Log info message:
```swift
BlackBox.info("Hello world")
```

Provide additional information:
```swift
BlackBox.debug("Logged in", userInfo: ["userId": user.id])
```
> Important: Do not include sensitive data in logs

Categorize logs:
```swift
BlackBox.debug("Logged in", userInfo: ["userId": someUserId], category: "App lifecycle")
```

Provide log level using argument:
```swift
BlackBox.log("Tried to open AuthScreen multiple times", level: .warning)
```

Log errors:
```swift
enum ParsingError: Error {
    case unknownCategoryInDTO(rawValue: Int)
}

BlackBox.log(ParsingError.unknownCategoryInDTO(rawValue: 9))
```

> Tip: For improved errors logging, see <doc:LoggingErrors>

Measure your code:
```swift
let log = BlackBox.debugStart("Parse menu") // or infoStart
let menuModel = MenuModel(dto: menuDto)
// any other hard work
BlackBox.logEnd(log)
```

or provide log level using argument:
```swift
let log = BlackBox.logStart("Parse menu", level: .warning)
```

Mix all of the above altogether:
```swift
BlackBox.info(
    "Geolocation service started",
    userInfo: ["accuracy": "low"]
    level: .info,
    category: "Location"
)
```


## Reading logs

BlackBox redirects all received logs to loggers.
Each logger in turn redirects logs to some target system, so to read logs you have to go there.

### Available Loggers
- ``OSLogger`` — logs to macOS Console.app and Xcode console.
- ``OSSignpostLogger`` — logs to Time Profiler.
- ``FSLogger`` — logs to text file.

> Tip: You can create your very own loggers and use it with BlackBox. For more information, see <doc:CustomLoggers_1_Base>

#### External Loggers
- [BlackBoxFirebasePerformance](https://github.com/dodobrands/BlackBoxFirebasePerformance) — redirects logs to Firebase Performance
- [BlackBoxFirebaseCrashlytics](https://github.com/dodobrands/BlackBoxFirebaseCrashlytics) — redirects logs to Firebase Crashlytics

If you've created your own logger — feel free to extend this list with PR.

### Setting up loggers
BlackBox automatically enables `OSLogger` and `OSSignpostLogger` with all available log levels.
You can customize this behaviour by assigning new BlackBox instance with required loggers:
```swift
let loggers = [
    OSLogger(levels: .allCases),
    OSSignpostLogger(levels: [.debug, .info])
    YourCustomLogger()
]
BlackBox.instance = BlackBox(loggers: loggers)
```
