import Cocoa

struct FileIO {
    /**
     Handles reading and writing text from and to files.
     
     - Parameters:
        - workingDirectory: path to prefix filenames (~/Documents)
     - Methods:
        - read(filename: String) -> String?
        - write(filename: String, content: String)
    */
    
    // Property initialization
    var wdUrl: URL
    
    init(workingDirectory wd: String?) {
        /**
            - Description:
                Initializes working directory to ~/Documents if workingDirectory is unspecified.
            - Parameters:
                workingDirectory: String
            - Returns:
                nothing
        */
        if let wD = wd {
            wdUrl = URL(fileURLWithPath: wD)
        } else {
            wdUrl = FileManager.default.homeDirectoryForCurrentUser
        }
    }
    
    mutating func setwd(wd: String) {
        /**
            - Description:
                Sets working directory
            - Parameters:
                wd: String
            - Returns:
                nothing
         */
        wdUrl = URL(fileURLWithPath: wd)
    }
    
    func read(filename: String) -> String? {
        /**
            - Description:
                Returns contents of file as String. Returns nil if no file.
            - Parameters:
                    filename: String
            - Returns:
                    String or nil
         */
        var content: String
        let fileURL = wdUrl.appendingPathComponent(filename)
        do {
            content = try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            print("\(fileURL) does not exist.")
            return nil
        }
        return content
    }
    
    func write(filename: String, content: String) {
        /**
            - Description:
                Writes String contents to file.
            - Parameters:
                filename: String
            - Returns:
                nothing
         */
        let fileURL = wdUrl.appendingPathComponent(filename)
        do {
            try content.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch {
            print(error)
        }
    }
}

