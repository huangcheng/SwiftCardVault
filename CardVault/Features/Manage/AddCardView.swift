//
//  AddCardView.swift
//  CardVault
//

import SwiftUI

struct AddCardView: View {
    @Binding var isPresented: Bool

    var body: some View {
        #if os(iOS)
        AddCardSheetView()
        #else
        AddCardDesktopView(isPresented: $isPresented)
        #endif
    }
}
