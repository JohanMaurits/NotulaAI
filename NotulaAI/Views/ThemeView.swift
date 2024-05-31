//
//  ThemeView.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 24/05/24.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme
    var body: some View {
        HStack{
            Text(theme.name)
                .frame(maxWidth: .infinity)
                .background(theme.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .foregroundStyle(theme.accentColor, .blue)
                .padding(4)
        }
    }
}

#Preview {
    ThemeView(theme: .buttercup)
}
