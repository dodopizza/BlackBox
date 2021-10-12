import Foundation

extension BlackBox {
    public class FSLogger: BBLoggerProtocol {
        private let fullpath: URL
        private let logLevels: [BBLogLevel]
        
        public init(path: URL,
                    name: String,
                    logLevels: [BBLogLevel]) {
            self.fullpath = path.appendingPathComponent(name)
            self.logLevels = logLevels
        }
        
        public func log(
            _ error: Error,
            file: StaticString,
            category: String?,
            function: StaticString,
            line: UInt
        ) {
            guard logLevels.contains(error.logLevel) else { return }
            
            let message = String(reflecting: error)
            
            log(message,
                userInfo: nil,
                logLevel: error.logLevel,
                file: file,
                category: category,
                function: function,
                line: line)
        }
        
        public func log(
            _ message: String,
            userInfo: CustomDebugStringConvertible?,
            logLevel: BBLogLevel,
            file: StaticString,
            category: String?,
            function: StaticString,
            line: UInt
        ) {
            guard logLevels.contains(logLevel) else { return }
            
            log(message,
                userInfo: userInfo,
                file: file,
                function: function,
                logLevel: logLevel)
        }
        
        public func logStart(
            _ entry: BlackBox.LogEntry,
            userInfo: CustomDebugStringConvertible?,
            logLevel: BBLogLevel,
            file: StaticString,
            category: String?,
            function: StaticString,
            line: UInt
        ) {
            guard logLevels.contains(logLevel) else { return }
            
            let formattedMessage = "\(BBEventType.start.description): \(entry.message)"
            
            log(
                formattedMessage,
                userInfo: userInfo,
                logLevel: logLevel,
                file: file,
                category: category,
                function: function,
                line: line
            )
        }
        
        public func logEnd(
            _ entry: BlackBox.LogEntry,
            userInfo: CustomDebugStringConvertible?,
            logLevel: BBLogLevel,
            file: StaticString,
            category: String?,
            function: StaticString,
            line: UInt
        ) {
            guard logLevels.contains(logLevel) else { return }
            
            let formattedMessage = "\(BBEventType.end.description): \(entry.message)"
            
            log(
                formattedMessage,
                userInfo: userInfo,
                logLevel: logLevel,
                file: file,
                category: category,
                function: function,
                line: line
            )
        }
    }
}

extension BlackBox.FSLogger {
    private func log(_ message: String,
                     userInfo: CustomDebugStringConvertible?,
                     file: StaticString,
                     function: StaticString,
                     logLevel: BBLogLevel) {
        let userInfo = userInfo?.bbLogDescription ?? "nil"
        
        let title = logLevel.icon + " " + String(describing: Date())
        let subtitle = file.bbFilename + ", " + function.description
        
        let content = message
        
        let footer = "[User Info]:" + "\n" + userInfo
        
        let messageToLog = title + "\n" + subtitle + "\n\n" + content + "\n\n" + footer + "\n\n\n"
        
        log(messageToLog)
    }
    
    private func log(_ string: String) {
        if let handle = try? FileHandle(forWritingTo: fullpath) {
            handle.seekToEndOfFile()
            handle.write(string.data(using: .utf8)!)
            handle.closeFile()
        } else {
            try? string.data(using: .utf8)?.write(to: fullpath)
        }
    }
}
