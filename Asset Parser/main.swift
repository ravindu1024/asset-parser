//
//  main.swift
//  Asset Parser
//
//  Created by Spritzer App on 15/3/20.
//  Copyright © 2020 Spritzer. All rights reserved.
//

import Foundation

let parser = Parser()

var projectPath = CommandLineUtils.getProjectPath()

if CommandLineUtils.hasHelp(){
    CommandLineUtils.printHelp()
    exit(0)
}

if CommandLineUtils.hasVersion(){
    CommandLineUtils.printVersion()
    exit(0)
}

if projectPath == nil || projectPath == ""{
    print("Project path not specified.")
    exit(0)
}

if let path = parser.findDirInPath(path: projectPath!, toFind: "Assets.xcassets"){
    print("found path: \(path)")

    var images = [File]()
    parser.findAllImageAssets(assetPath: path, files: &images)

    images.forEach{
        print("imageasset: \($0.name)")
    }

    let content = parser.createAssetsClass(images: images)
    FileUtils.writeFile(path: "\(projectPath!)/R.swift", content: content)

    print("Created R.swift")
}




