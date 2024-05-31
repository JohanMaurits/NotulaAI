//
//  HistoryView.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 26/05/24.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Peserta")
                    .font(.headline)
                Text(history.attendeeString)
                if let transcript = history.transcript {
                    Text("Transkrip")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
                if let summary = history.summary {
                    Label("Kesimpulan Rapat by NotulaAi", systemImage: "waveform.badge.mic")
                        .font(.headline)
                        .padding(.top)
                        .foregroundStyle(.purple)
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(extractSections(from: summary), id: \.self) { section in
                            Text(section.title)
                                .font(.headline)
                                .padding(.vertical, 2)
                            
                            ForEach(section.content, id: \.self) { content in
                                parseTextForBold(content)
                                    .padding(.leading, 10)
                            }
                        }
                        .textSelection(.enabled)
                    }
                    
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
    
    
    private func extractSections(from text: String) -> [Section] {
            let sections = text.components(separatedBy: "###")
                .filter { !$0.isEmpty }
                .map { section -> Section in
                    let lines = section.split(separator: "\n", omittingEmptySubsequences: true)
                        .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
                    let title = lines.first ?? ""
                    let content = Array(lines.dropFirst())
                    return Section(title: title, content: content)
                }
            return sections
        }

        private func parseTextForBold(_ text: String) -> Text {
            var outputText = Text("")
            let parts = text.components(separatedBy: "**")
            
            var isBold = false
            for part in parts {
                if isBold {
                    outputText = outputText + Text(part).bold()
                } else {
                    outputText = outputText + Text(part)
                }
                isBold.toggle()
            }
            
            return outputText
        }

        struct Section: Hashable {
            let title: String
            let content: [String]
        }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var history: History {
        History(attendees: [
            Meeting.Attendees(name: "Johan"),
            Meeting.Attendees(name: "Fernando"),
            Meeting.Attendees(name: "Prima")
        ],
                transcript: "Prima, bagaimana dengan fitur aplikasi tambahan yang diminta oleh pak Fernando, apakah sudah dikerjakan?",
                summary: """
            ### Ringkasan Diskusi
            Diskusi ini dipimpin oleh Johan dari Kementerian Sekretariat Negara dan berfokus pada perbaikan serta pengembangan aplikasi yang digunakan oleh kementerian. Pembahasan utama adalah tentang penambahan fitur baru yang memungkinkan akses penghasilan bagi pegawai berpenghasilan lebih. Johan menekankan bahwa meskipun ada agenda kerja lain yang penting, prioritas saat ini adalah mengembangkan dan memperbaiki fitur ini dalam waktu dua bulan ke depan.

            ### Action Items
            - **Pengembangan Fitur Baru**: Tim pengembang aplikasi harus merancang dan mengimplementasikan fitur penghasilan yang baru. Tugas ini akan diawasi oleh Johan untuk memastikan bahwa pengembangan berjalan sesuai jadwal.
            - **Pengujian Fitur**: Setelah fitur baru dikembangkan, perlu dilakukan pengujian untuk memastikan bahwa semua berfungsi dengan baik dan sesuai dengan kebutuhan pegawai.
            - **Integrasi dan Peluncuran**: Setelah pengujian selesai, fitur harus diintegrasikan ke dalam aplikasi yang ada dan diluncurkan untuk digunakan oleh pegawai.

            ### Topik Diskusi untuk Pertemuan Berikutnya
            - **Evaluasi Awal Penggunaan Fitur Baru**: Menganalisis feedback dari pengguna mengenai fitur baru.
            - **Kebutuhan Pengembangan Fitur Tambahan**: Mendiskusikan apakah ada kebutuhan untuk menambahkan fitur lain berdasarkan masukan dari evaluasi penggunaan.
            - **Pembaruan Keamanan Aplikasi**: Mempertimbangkan update keamanan untuk melindungi data pengguna dan sistem dari ancaman eksternal.
            """)
    }
    
    static var previews: some View {
        HistoryView(history: history)
    }
}
