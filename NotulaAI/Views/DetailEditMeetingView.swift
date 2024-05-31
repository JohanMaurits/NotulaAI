//
//  DetailEditMeetingView.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 24/05/24.
//

import SwiftUI

struct DetailEditMeetingView: View {
    @Binding var meeting: Meeting
    @State private var newAttendeeName = ""
    var body: some View {
        Form{
            Section(header: Text("Info Rapat")){
                TextField("Judul Rapat", text: $meeting.title)
                HStack{
                    Slider(value: $meeting.lengthInMinutesAsDouble, in: 5...120, step: 5){
                        Text("Durasi")
                    }
                    .accessibilityValue("\(meeting.lengthInMinutes) menit")
                    Spacer()
                    Text("\(meeting.lengthInMinutes) menit")
                        .accessibilityHidden(true)
                }
                ThemePickerView(selection: $meeting.theme)
            }
            
            Section(header: Text("Peserta Rapat")){
                ForEach(meeting.attendees){ atendee in
                    Text(atendee.name)
                }
                .onDelete(perform: { indexSet in
                    meeting.attendees.remove(atOffsets: indexSet)
                })
                HStack{
                    TextField("Peserta baru", text: $newAttendeeName)
                    Button(action: {
                        withAnimation{
                            let attendee = Meeting.Attendees(name: newAttendeeName)
                            meeting.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
        .frame(minWidth: 300, minHeight: 200)
        .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DetailEditMeetingView(meeting: .constant(Meeting.sampleData[0]))
}
