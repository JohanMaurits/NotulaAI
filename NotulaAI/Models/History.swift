//
//  History.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 25/05/24.
//

import Foundation

struct History: Identifiable, Codable{
    let id: UUID
    let date: Date
    let attendees: [Meeting.Attendees]
    var transcript: String?
    var summary: String?
    
    internal init(id: UUID = UUID(), date: Date = Date(), attendees: [Meeting.Attendees], transcript: String? = nil, summary: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.transcript = transcript
        self.summary = summary
    }
}
