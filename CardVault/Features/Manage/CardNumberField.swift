//
//  CardNumberField.swift
//  CardVault
//

import SwiftUI

struct CardNumberField: View {
    @Bindable var formState: AddCardFormState

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                TextField(String(localized: "0000 0000 0000 0000"), text: Binding(
                    get: { formState.formattedCardNumber },
                    set: { newValue in
                        formState.cardNumberRaw = newValue.filter(\.isNumber)
                    }
                ))
                .font(.cardNumber)
                .foregroundStyle(Color.onSurface)
                #if os(iOS)
                .keyboardType(.numberPad)
                #endif
                .onChange(of: formState.cardNumberRaw) {
                    formState.validateCardNumber()
                }

                Image(systemName: "lock.fill")
                    .font(.body)
                    .foregroundStyle(Color.onSurfaceVariant)
            }
            .padding(14)
            .background(Color.surfaceContainerLow)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            if let error = formState.cardNumberError {
                Text(error)
                    .font(.labelSM)
                    .foregroundStyle(Color.errorToken)
            }
        }
    }
}
