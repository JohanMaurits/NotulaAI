//
//  ThemePickerView.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 24/05/24.
//

import SwiftUI

struct ThemePickerView: View {
    @Binding var selection: Theme
    var body: some View {
        Picker("Tema", selection: $selection, content: {
            ForEach(Theme.allCases, content: { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            })
        })
        .pickerStyle(.menu)
    }
}

#Preview {
    ThemePickerView(selection: .constant(.periwinkle))
}
