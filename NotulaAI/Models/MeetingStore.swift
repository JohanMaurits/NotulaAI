//
//  MeetingStore.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 25/05/24.
//

import Foundation

@MainActor
class MeetingStore: ObservableObject{
    @Published var meetings: [Meeting] = []
    
    private static func fileURL() throws -> URL{
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("meeting.data")
    }
    
    func load() async throws{
        let task = Task<[Meeting], Error>{
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else{
                return[]
            }
            let readMeetings = try JSONDecoder().decode([Meeting].self, from: data)
            return readMeetings
        }
        
        let meetings = try await task.value
        self.meetings = meetings
    }
    
    func save(meetings: [Meeting]) async throws{
        let task = Task{
            let data = try JSONEncoder().encode(meetings)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        
        _ = try await task.value
    }
}
