//
//  ContentView.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 21/05/24.
//

import SwiftUI
import AVFoundation

struct RecordingView: View {
    @EnvironmentObject var loadingState: LoadingState
    @State private var summarizedText: String = ""
    @Binding var meeting: Meeting
    @StateObject var recordingTimer = RecordingTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @State var isLoading = false
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(meeting.theme.mainColor)
            VStack {
                
                RecordingHeaderView(secondsElapsed: recordingTimer.secondsElapsed, secondsRemaining: recordingTimer.secondsRemaining, theme: meeting.theme)
                RecordingTimerView(speakers: recordingTimer.speakers, isRecording: isRecording, theme: meeting.theme)
                RecordingFooterView(speakers: recordingTimer.speakers, skipAction: recordingTimer.skipSpeaker)
            }

            .padding(40)
            
        }
        .foregroundStyle(meeting.theme.accentColor)
        .onAppear {
            startMeeting()
        }
        .onDisappear(perform: {
            endSMeeting()
        })
    }
    //TODO: Ini juga lebih bagus kalau di ModelView
    private func startMeeting(){
        recordingTimer.reset(lengthInMinutes: meeting.lengthInMinutes, attendees: meeting.attendees)
        recordingTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        recordingTimer.startRecording()
    }
    
    private func endSMeeting() {
        recordingTimer.stopRecording()
        speechRecognizer.stopTranscribing()
        isRecording = false
        loadingState.isLoading = true
        OpenAIModel.shared.summarize(text: speechRecognizer.transcript) { summary in
            summarizedText = summary
            let newHistory = History(attendees: meeting.attendees, transcript: speechRecognizer.transcript, summary: summarizedText)
            meeting.history.insert(newHistory, at: 0)
            loadingState.isLoading = false
        }
        
        
        
    }
    
}

#Preview {
    RecordingView(meeting: .constant(Meeting.sampleData[0]))
}
