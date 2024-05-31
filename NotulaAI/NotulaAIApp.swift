//
//  NotulaAIApp.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 21/05/24.
//

import SwiftUI

@main
struct NotulaAIApp: App {
    @StateObject private var store = MeetingStore()
    @State private var errorWrapper: ErrorWrapper?
    var body: some Scene {
        WindowGroup {
            
            MeetingView(meetings: $store.meetings){
                Task{
                    do{
                        try await store.save(meetings: store.meetings)
                    } catch{
                        errorWrapper = ErrorWrapper(error: error, guidance: "Coba kembali.")
                    }
                }
            }
                .task {
                    do{
                        try await store.load()
                    } catch{
                        errorWrapper = ErrorWrapper(error: error, guidance: "NotulaAI sedang mengambil data dari sistem.")
                    }
                }
                .sheet(item: $errorWrapper) {
                    store.meetings = Meeting.sampleData
                } content: { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
                .environmentObject(LoadingState())
        }
    }
}
