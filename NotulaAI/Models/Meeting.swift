//
//  Meeting.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 21/05/24.
//

import Foundation

struct Meeting: Identifiable, Codable{
    let id: UUID
    var title: String
    var attendees: [Attendees]
    var lengthInMinutes: Int
    var lengthInMinutesAsDouble: Double{
        get{
            Double(lengthInMinutes)
        }
        set{
            lengthInMinutes = Int(newValue)
        }
    }
    var theme: Theme
    var history: [History] = []
    
    internal init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map{ Attendees(name: $0)}
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
    
}

extension Meeting{
    struct Attendees: Identifiable, Codable{
        let id: UUID
        var name: String
        
        internal init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
        
    }
    
    static var emptyMeeting: Meeting{
        Meeting(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
    }
}



extension Meeting{
    static let sampleData: [Meeting] =
    [
        Meeting(title: "Aplikasi",
                attendees: ["Johan", "Fernando", "Prima", "Rizky"],
                lengthInMinutes: 10,
                theme: .seafoam),
        Meeting(title: "Jaringan",
                attendees: ["Rizal", "Abi", "Insan"],
                lengthInMinutes: 5,
                theme: .lavender),
        Meeting(title: "SPBE", 
                attendees: ["Yusri", "Elis", "Rina", "Insan", "Sonia"],
                lengthInMinutes: 5,
                theme: .bubblegum)
    ]
}
