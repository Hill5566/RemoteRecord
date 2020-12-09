//
//  ZoetekDataProcessor.swift
//  HealthCare
//
//  Created by Johnny on 2019/5/28.
//  Copyright © 2019 extreamax. All rights reserved.
//

import Foundation

class ZoetekDataProcessor {
    static func deserializeBytesToString(_ data: [UInt8]) -> String? {
        //判斷是否有資料
        if (!data.isEmpty) {
            //宣告檢查碼
            var checksum = 0
            //計算檢查碼
            if data.count < 3 {
                return nil
            }
            for i in 1...(data.count-2) {
                checksum += Int(data[i])
            }

            //判斷檢查碼是否正確
            if (intToHexString(UInt8(checksum & 0xFF)) == intToHexString(data[data.count - 1] & 0xFF)) {
                //宣告資料變數
                //取出header部分
                let head = data[0]
//                print("Header = " + intToHexString(head & 0xFF))
                //取出資料部分位元組
                let bleData:[UInt8] = arrayTake(m: 2, n: data.count - 2, arrayIn: data)
                
                //將資料部分位元組轉為文字
                if let text = String(bytes: bleData, encoding: .utf8) {
                    //去除空白字元
                    return text.trimmingCharacters(in: .whitespacesAndNewlines)
                } else {
//                    print("not a valid UTF-8 sequence")
                }
            }
        }
        return nil
    }
    
    // Serialize
    static func serializeStringToBytes(_ msg: String) -> [UInt8] {
        //依照 Zoetek Protocol 格式傳送資料
        //宣告 20Byte 資料變數
        var data:[UInt8] = [UInt8].init(repeating: 0x00, count: 2 + msg.count + 1)
        //宣告標頭
        let head: UInt8 = 0x00
        //宣告類型
        let type: UInt8 = 0x80
        //加入標頭與類型
        data[0] = head
        data[1] = type
        //宣告檢查碼
        var checksum = 0
        //計算檢查碼
        let msgBytes:[UInt8] = Array(msg.utf8)
        for i in 0...(msgBytes.count - 1) {
            checksum += Int(msgBytes[i])
            data[i + 2] = UInt8(msgBytes[i])
        }
        checksum = checksum & 0xFF
        checksum = checksum + Int(type) & 0xFF & 0xFF
        //加入檢查碼
        data[2 + msg.count] = UInt8(checksum & 0xFF)
        //發送資料
        return data
    }
    
    static func intToHexString(_ n: UInt8) -> String {
        return String(format:"%02X", n)
    }
    
    static func byteArrayToHex(_ a: [UInt8]) -> String {
        var str = ""
        for n in a {
            str += intToHexString(n) + " "
        }
        return str
    }
    
    static func arrayTake<T>(m: Int, n: Int, arrayIn: Array<T>) -> Array<T> {
        return Array(arrayIn[m...n])
    }
    
}
