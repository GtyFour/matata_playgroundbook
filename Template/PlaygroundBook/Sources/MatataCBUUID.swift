//
//  MatataCBUUID.swift
//  Book_Sources
//
//  Created by GtyFour on 2019/1/2.
//

import Foundation
import CoreBluetooth

extension CBUUID{
    @nonobjc static let MatataServiceUUID = CBUUID(string:"6E400001-B5A3-F393-E0A9-E50E24DCCA9E")
    @nonobjc static let MatataNotifyUUID = CBUUID(string:"6E400003-B5A3-F393-E0A9-E50E24DCCA9E")
    @nonobjc static let MatataWriteUUID = CBUUID(string:"6E400002-B5A3-F393-E0A9-E50E24DCCA9E")
}
