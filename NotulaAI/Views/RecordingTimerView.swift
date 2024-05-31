//
//  RecordingTimerView.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 26/05/24.
//

import SwiftUI

struct RecordingTimerView: View {
    let speakers: [RecordingTimer.Speaker]
    let isRecording: Bool
    let theme: Theme
    
    private var currentSpeaker: String {
           speakers.first(where: { !$0.isCompleted })?.name ?? "Someone"
       }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 18)
            .overlay {
                VStack(spacing: 7) {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("sedang berbicara")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "transkripsi suara aktif" : "transripsi tidak aktif")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 8)
                    }
                }
            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers: [RecordingTimer.Speaker] {
        [RecordingTimer.Speaker(name: "Johan", isCompleted: false), RecordingTimer.Speaker(name: "Prima", isCompleted: true)]
    }
    
    static var previews: some View {
        RecordingTimerView(speakers: speakers, isRecording: false, theme: .yellow)
    }
}
