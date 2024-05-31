//
//  TrailingIconLabelStyle.swift
//  NotulaAI
//
//  Created by Johan Sianipar on 22/05/24.
//

import Foundation
import SwiftUI

struct TrailingIconLabelStyle: LabelStyle{
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            configuration.icon
            configuration.title
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle{
    static var trailingIcon: Self { Self()}
}
