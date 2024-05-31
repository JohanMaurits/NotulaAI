//
//  CardView.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 22/05/24.
//

import SwiftUI

struct CardView: View {
    let meeting: Meeting
    var body: some View {
        VStack(alignment: .leading) {
            Text(meeting.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack{
                Label("\(meeting.attendees.count)", systemImage: "person.3")
                    .accessibilityLabel("\(meeting.attendees.count) peserta")
                Spacer()
                Label("\(meeting.lengthInMinutes) menit", systemImage: "clock")
                    .accessibilityLabel("Waktu rapat, \(meeting.lengthInMinutes) menit")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .foregroundStyle(meeting.theme.accentColor)
        .padding()
    }
}

//#Preview {

//    CardView(meeting: meeting)
//}

struct CardView_Previews: PreviewProvider{
    static var meeting = Meeting.sampleData[0]
    static var previews: some View{
        CardView(meeting: meeting)
            .background(meeting.theme.mainColor)
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/60.0/*@END_MENU_TOKEN@*/))
    }
}
