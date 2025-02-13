//
//  Print.swift
//  Runner
//
//  Created by Rahmat Trinanda Pramudya Amar on 11/01/25.
//

import Foundation

public func printIfDebug(
    file: String = #file,
    line: UInt = #line,
    _ items: Any...,
    separator: String = " ",
    terminator: String = "\n"
) {
#if DEBUG
    var newItems: [Any] = ["||", String(describing: file.split(separator: "/").last?.split(separator: ".").first ?? ""), "-", String(describing: line), "||"]
    newItems.append(contentsOf: items)
    print(newItems.map { "\($0)" }.joined(separator: separator), terminator: terminator)
#endif
}
