//
// Created by Spritzer App on 15/3/20.
// Copyright (c) 2020 Spritzer. All rights reserved.
//

import Foundation
class CommandLineUtils {
    public static func printHelp(){
        let help = """
                   Asset Parser Help
                   Supported Arguments
                   -p iOS Project Path
                   -h Help
                   -v Version
                   """

        print(help)
    }

    public static func printVersion(){
        print("Asset Parser version 1.0")
    }

    public static func getProjectPath() -> String?{
        let index = CommandLine.arguments.firstIndex(of: "-p")
        if index != nil{
            return CommandLine.arguments[(index ?? 0) + 1]
        }else{
            return nil
        }
    }

    public static func hasHelp() -> Bool{
        return CommandLine.arguments.first(where: { $0 == "-h" }) != nil
    }

    public static func hasVersion() -> Bool{
        return CommandLine.arguments.first(where: { $0 == "-v" }) != nil
    }
}