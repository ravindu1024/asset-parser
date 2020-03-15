//
// Created by Spritzer App on 15/3/20.
// Copyright (c) 2020 Spritzer. All rights reserved.
//

import Foundation

class Parser {

    func findDirInPath(path: String, toFind: String) -> String?{
        var found: String? = nil

        print("Searching dir: \(path)")

        let files = FileUtils.getFilesIn(dir: path)
        if files.first(where: { $0.name == toFind }) != nil {
            found = path
        } else {
            let dirs = files.filter({ $0.isDir })
            for dir in dirs{
                found = findDirInPath(path: dir.absolutePath, toFind: toFind)
                if found != nil{
                    break
                }
            }
        }

        return found
    }

    func findAllImageAssets(assetPath: String, files: inout [File]){
        let filesInPath = FileUtils.getFilesIn(dir: assetPath)

        files.append(contentsOf: filesInPath.filter({ $0.name.contains(".imageset") }))

        filesInPath.filter({ $0.isDir }).forEach{ file in
            findAllImageAssets(assetPath: file.absolutePath, files: &files)
        }
    }

    func createAssetsClass(images: [File]) -> String{

        var content = """
                      // -----------------------------------------------------------------
                      // DO NOT MODIFY.
                      // This is an auto generated class.
                      // Created by Asset Parser. 
                      // Github: https://www.github.com/ravindu1024/asset-parser
                      // -----------------------------------------------------------------
                      """
        content.append("\n\nclass R {\n\tclass Assets{\n\t\t")
        images.forEach{ file in
            let name = file.name.replacingOccurrences(of: ".imageset", with: "")
            let varName = name
                    .replacingOccurrences(of: " ", with: "_")
                    .replacingOccurrences(of: "-", with: "_")
                    .replacingOccurrences(of: "(", with: "_")
                    .replacingOccurrences(of: ")", with: "_")
            content.append("\n\t\tpublic static let \(varName) = \"\(name)\"")
        }

        content.append("\t}\n}")

        return content
    }
}