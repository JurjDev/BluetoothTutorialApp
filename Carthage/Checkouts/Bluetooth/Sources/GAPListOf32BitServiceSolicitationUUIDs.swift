//
//  GAPListOf32BitServiceSolicitationUUIDs.swift
//  Bluetooth
//
//  Created by Carlos Duclos on 6/13/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

import Foundation

/// GAP List of 32 bit Service Solicitation UUIDs
public struct GAPListOf32BitServiceSolicitationUUIDs: GAPData, Equatable {
    
    public static let dataType: GAPDataType = .listOf32BitServiceSolicitationUUIDs
    
    public let uuids: [UInt32]
    
    public init(uuids: [UInt32] = []) {
        
        self.uuids = uuids
    }
    
   public init?(data: Data) {
        
        guard let list = GAPUUIDList<UInt32>(data: data)
            else { return nil }
        
        self.uuids = list.uuids
    }
    
    public var data: Data {
        
        return GAPUUIDList<UInt32>(uuids: uuids).data
    }
}

// MARK: - ExpressibleByArrayLiteral

extension GAPListOf32BitServiceSolicitationUUIDs: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: UInt32...) {
        
        self.init(uuids: elements)
    }
}

// MARK: - CustomStringConvertible

extension GAPListOf32BitServiceSolicitationUUIDs: CustomStringConvertible {
    
    public var description: String {
        
        return uuids.description
    }
}
