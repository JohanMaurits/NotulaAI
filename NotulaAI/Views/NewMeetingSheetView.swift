//
//  NewMeetingSheetView.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 25/05/24.
//

import SwiftUI

struct NewMeetingSheetView: View {
    @State private var newMeeting = Meeting.emptyMeeting
    @Binding var meetings: [Meeting]
    @Binding var isPresentingNewMeetingView: Bool
    var body: some View {
        NavigationStack{
            DetailEditMeetingView(meeting: $newMeeting)
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction, content: {
                        Button("Batal", action: {
                            isPresentingNewMeetingView = false
                        })
                    })
                    ToolbarItem(placement: .confirmationAction, content: {
                        Button("Tambah", action: {
                            meetings.append(newMeeting)
                            isPresentingNewMeetingView = false
                        })
                    })
                })
        }
    }
}

#Preview {
    NewMeetingSheetView(meetings: .constant(Meeting.sampleData), isPresentingNewMeetingView: .constant(true))
}
