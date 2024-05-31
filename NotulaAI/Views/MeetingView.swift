//
//  MeetingView.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 22/05/24.
//

import SwiftUI

struct MeetingView: View {
    @Binding var meetings: [Meeting]
    @Environment(\.scenePhase) private var scenePhase
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    @State private var selectedMeetingGroup: Meeting? = nil
    @State private var isPresentingNewMeetingView = false
    @State private var isSelected: Bool = false
    
    let saveAction: ()->Void
    var body: some View {
        NavigationStack {
            List($meetings) { $meeting in
                NavigationLink(destination: DetailMeetingView(meeting: $meeting)) {
                    CardView(meeting: meeting)
                }
                .listRowBackground(meeting.theme.mainColor)
            }
            .navigationTitle("NotulaAI - Dashboard")
            .toolbar {
                Button(action: {
                    isPresentingNewMeetingView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewMeetingView, content: {
            NewMeetingSheetView(meetings: $meetings, isPresentingNewMeetingView: $isPresentingNewMeetingView)
        })
        .onChange(of: scenePhase) {
            if scenePhase == .inactive { saveAction() }
        }
        
        
    }
}

#Preview {
    MeetingView(meetings: .constant(Meeting.sampleData), saveAction: {})
        .environmentObject(LoadingState())
}
