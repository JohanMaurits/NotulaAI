//
//  DetailMeetingView.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 22/05/24.
//

import SwiftUI

struct DetailMeetingView: View {
    @EnvironmentObject var loadingState: LoadingState
    @Binding var meeting: Meeting
    @State private var editingMeeting = Meeting.emptyMeeting
    @State private var isPresentingEditView = false
    var body: some View {
        List{
            Section(header: Text("Informasi Rapat")) {
                NavigationLink(destination: RecordingView(meeting: $meeting), label: {
                    Label("Mulai Rapat", systemImage: "play")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                })
                
                HStack {
                    Label("Durasi", systemImage: "clock")
                    Spacer()
                    Text("\(meeting.lengthInMinutes) menit")
                }
                .accessibilityElement(children: .combine)
                HStack{
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text("\(meeting.theme.name)")
                        .padding(4)
                        .foregroundColor(meeting.theme.accentColor)
                        .background(meeting.theme.mainColor) .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Peserta Rapat")){
                ForEach(meeting.attendees){ atendee in
                    Text(atendee.name)
                }
            }
            
            Section(header: Text("Riwayat")){
                if meeting.history.isEmpty{
                    if loadingState.isLoading{
                        Label("NotulaAi sedang membuat kesimpulan rapat...", systemImage: "waveform.badge.mic")
                            .font(.headline)
                            .padding(.top)
                            .foregroundStyle(.purple)
                    }
                    else{
                        Label("Tidak ada rekaman rapat", systemImage: "calendar.badge.exclamationmark")
                    }
                }
                ForEach(meeting.history){ history in
                    NavigationLink(destination: HistoryView(history: history)) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
            }
        }
        .navigationTitle(meeting.title)
        .toolbar(content: {
            Button("Ubah", action: {
                isPresentingEditView = true
                editingMeeting = meeting
            })
        })
        .sheet(isPresented: $isPresentingEditView, content: {
            NavigationStack{
                DetailEditMeetingView(meeting: $editingMeeting)
                    .navigationTitle(meeting.title)
                    .toolbar(content: {
                        ToolbarItem(placement: .cancellationAction, content: {
                            Button("Batal", action: {
                                isPresentingEditView = false
                            })
                        })
                        ToolbarItem(placement: .confirmationAction, content: {
                            Button("Simpan", action: {
                                isPresentingEditView = false
                                meeting = editingMeeting
                            })
                        })
                    })
            }
        })
    }
}

#Preview {
    NavigationStack{
        DetailMeetingView(meeting: .constant(Meeting.sampleData[0]))
            .environmentObject(LoadingState())
    }
    
}
