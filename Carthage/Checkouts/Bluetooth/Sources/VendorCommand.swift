//
//  VendorCommand.swift
//  Bluetooth
//
//  Created by Alsey Coleman Miller on 3/23/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

import Foundation

public struct VendorCommand: HCICommand, Equatable, Hashable {
    
    public static let opcodeGroupField = HCIOpcodeGroupField.vendor
    
    public let rawValue: HCIOpcodeCommandField
    
    public init(rawValue: HCIOpcodeCommandField) {
        
        self.rawValue = rawValue
    }
}

// MARK: - Name

public extension VendorCommand {
    
    /// The names of the registered vendor commands.
    public static var names = [VendorCommand: String]()
    
    public var name: String {
        
        return type(of: self).names[self] ?? rawValue.toHexadecimal()
    }
}
