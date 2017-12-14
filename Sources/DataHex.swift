// Copyright © 2017 Trust.
//
// This file is part of Trust. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

extension Data {
    /// Initializes `Data` with a hex string representation.
    init?(hexString: String) {
        let string: Substring
        if hexString.hasPrefix("0x") {
            string = hexString.dropFirst(2)
        } else {
            string = Substring(hexString)
        }

        self.init(capacity: string.count / 2)
        for offset in stride(from: 0, to: string.count, by: 2) {
            let start = string.index(string.startIndex, offsetBy: offset)
            let end = string.index(string.startIndex, offsetBy: offset + 2)
            let byte = string[start ..< end]
            guard let number = UInt8(byte, radix: 16) else {
                return nil
            }
            append(number)
        }
    }

    /// Returns the hex string representation of the data.
    var hexString: String {
        var string = ""
        for byte in self {
            string.append(String(format: "%02x", byte))
        }
        return string
    }
}
