//
//  KeyboardDismiss.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import SwiftUI

// 키보드를 내리는 기능을 View extension으로 만들어 재사용성을 높입니다
extension View {
    func dismissKeyboard() -> some View {
        return self
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
    }
}
