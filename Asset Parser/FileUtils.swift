//
//  FileUtils.swift
//  Asset Parser
//
//  Created by Spritzer App on 15/3/20.
//  Copyright © 2020 Spritzer. All rights reserved.
//

import Foundation
import FileProvider

struct File{
    var name: String
    var absolutePath: String
    var parentDirectory: String
    var parentDirectoryName: String
    var isDir: Bool
}

class FileUtils{
    
    static func getFilesIn(dir: String) -> [File]{
        
        var files = [File]()
        if let filesInDir = try? FileManager.default.contentsOfDirectory(atPath: dir){
            files = filesInDir.map({ name in

                return File(name: name, absolutePath: "\(dir)/\(name)", parentDirectory: dir, parentDirectoryName: dir.getDirNameFromPath(), isDir: "\(dir)/\(name)".isDir())
            })
        }
        
        return files
    }

    static func writeFile(path: String, content: String){
        FileManager.default.createFile(atPath: path, contents: content.data(using: String.Encoding.utf8))
    }
}

extension String{
    public func isDir() -> Bool{
        var isDir = false
        if let type = try? FileManager.default.attributesOfItem(atPath: self).first(where: { $0.key == FileAttributeKey.type }){
            isDir = type.value as? FileAttributeType == FileAttributeType.typeDirectory
        }

        return isDir
    }

    func getDirNameFromPath() -> String{
        let components = self.components(separatedBy: "/")
        return components[components.count - 1]
    }
}


