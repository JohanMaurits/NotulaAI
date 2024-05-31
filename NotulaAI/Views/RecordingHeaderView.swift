//
//  MeetingHeaderView.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 24/05/24.
//

import SwiftUI

struct RecordingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    
    //TODO: Logic function kayak gini kyknya bagusan di ModelView
    private var totalSeconds: Int{
        secondsElapsed + secondsRemaining
    }
    
    private var progress: Double{
        guard totalSeconds > 0 else{ return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    private var minutesRemaining: Int{
        secondsRemaining / 60
    }
    
    var body: some View {
        VStack{
            ProgressView(value: progress)
                .progressViewStyle(RecordingProgressViewStyle(theme: theme))
            HStack{
                VStack(alignment: .leading) {
                    Text("Waktu berjalan (detik)")
                    Label("\(secondsElapsed)", systemImage: "hourglass.tophalf.fill")
                }
                .font(.caption)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Waktu tersisa (detik)")
                    Label("\(secondsRemaining)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }.font(.caption)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Waktu yang tersisa")
            .accessibilityValue("\(minutesRemaining)")
            .padding([.top, .horizontal])
        }
    }
}

#Preview {
    RecordingHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .buttercup)
        .previewLayout(.sizeThatFits)
}
