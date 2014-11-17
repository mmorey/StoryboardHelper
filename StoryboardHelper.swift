#!/usr/bin/env xcrun swift

import Foundation

let extensionHeader = "// Auto generated file from StoryboardConstants, any manual changes will be lost.\n\nimport UIKit\n\npublic extension UIStoryboard {"
let functionTemplate = "\n\n    class func $NAME$Storyboard() -> UIStoryboard { \n        return UIStoryboard(name: \"$FILENAME$\", bundle:nil)\n    }"
let extensionFooter = "\n\n}"

let totalArguments = Int(C_ARGC) - 1
var inputPath:String
var outputPath:String
if totalArguments == 2 {
    inputPath = String.fromCString(C_ARGV[1])!
    outputPath = String.fromCString(C_ARGV[2])!
} else {
    println("Usage:")
    println("    $ StoryboardHelper.swift INPUT_PATH OUTPUT_PATH")
    exit(1)
}

var manager:NSFileManager = NSFileManager.defaultManager()
var storyboardArray = Array<String>()
if let directoryEnumerator:NSDirectoryEnumerator = manager.enumeratorAtPath(inputPath) {
    while let element = directoryEnumerator.nextObject() as? String {
        if element.hasSuffix("storyboard") {
            storyboardArray.append(element)
            println("Found Storyboard: \(element)")
        }
    }
} else {
    println("Invalid input path.")
    exit(1)
}

NSFileManager.defaultManager().createFileAtPath(outputPath, contents: NSData(), attributes: nil)
if let fileHandle = NSFileHandle(forWritingAtPath: outputPath) {

    fileHandle.writeData(extensionHeader.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!)

    for storyboardPath in storyboardArray {
        fileHandle.seekToEndOfFile()
        let storyboardFileName = storyboardPath.lastPathComponent.stringByDeletingPathExtension
        let firstCharacterIndex = advance(storyboardFileName.startIndex, 1)
        let firstCharacter = storyboardFileName.substringToIndex(firstCharacterIndex).lowercaseString
        let restOfFileName = storyboardFileName.substringFromIndex(firstCharacterIndex)
        let camelCaseFileName = firstCharacter + restOfFileName
        let storyboardMethodWithName = functionTemplate.stringByReplacingOccurrencesOfString("$NAME$", withString: camelCaseFileName, options: NSStringCompareOptions.LiteralSearch, range: nil)
        let storyboardMethodWithFileName = storyboardMethodWithName.stringByReplacingOccurrencesOfString("$FILENAME$", withString: storyboardFileName, options: NSStringCompareOptions.LiteralSearch, range: nil)
        let storyboardPathData = storyboardMethodWithFileName.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        fileHandle.writeData(storyboardPathData)
    }

    fileHandle.writeData(extensionFooter.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!)
    fileHandle.closeFile()
} else {
    println("Invalid output path.")
    exit(1)
}

exit(0)
