//
//  RecordingFooterView.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 24/05/24.
//

import SwiftUI

struct RecordingFooterView: View {
    let speakers: [RecordingTimer.Speaker]
    var skipAction: ()->Void
    
    private var speakerNumber: Int? {
            guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
            return index
        }
    private var isLastSpeaker: Bool {
            return speakers.dropLast().allSatisfy { $0.isCompleted }
        }
    private var speakerText: String {
            guard let speakerNumber = speakerNumber else { return "Tidak ada pembicara" }
            return "Pembicara ke-\(speakerNumber + 1) dari \(speakers.count)"
        }
    private var speakerName: String{
        return "\(speakers[speakerNumber!].name)"
    }
    var body: some View {
        VStack(alignment:.leading){
            Label("\(speakerName) sedang berbicara..", systemImage: "person.wave.2")
            
            HStack {
                if isLastSpeaker{
                    Text("Pembicara terakhir")
                }
                else{
                    Text(speakerText)
                    Spacer()
                    Button("Ganti Pembicara", systemImage: "forward.fill", action:skipAction)
                }
            }
            .accessibilityLabel("Pembicara selanjutnya")
        }
        .padding([.bottom, .horizontal])
    }
}

#Preview {
    RecordingFooterView(speakers: Meeting.sampleData[0].attendees.speakers, skipAction: {})
        .previewLayout(.sizeThatFits)
}
