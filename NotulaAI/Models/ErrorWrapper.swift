//
//  ErrorWrapper.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 26/05/24.
//

import Foundation

struct ErrorWrapper: Identifiable{
    let id: UUID
    let error: Error
    let guidance: String
    
    internal init(id: UUID = UUID(), error: any Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
