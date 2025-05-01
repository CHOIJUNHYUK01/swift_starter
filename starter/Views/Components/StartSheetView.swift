//
//  StartSheetView.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import SwiftUI

struct StartSheetView: View {
    @AppStorage("userName") private var userName = ""
    @State private var name = ""
    
    let characterLimit = 15
    var onSuccess: () -> Void = {}
    var onDismiss: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            TextFieldView
            ButtonView
            ExplainView
        }
        .frame(height: 180)
        .foregroundStyle(.white)
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        }
        .shadow(color: .black.opacity(0.12), radius: 8)
        .padding(.horizontal, 16)
    }
    
    private var TextFieldView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("이름 설정")
                .pretendardStyle(by: .Regular, on: .Callout, fill: .black.opacity(0.5))
            
            ZStack {
                HStack(spacing: 4) {
                    Image(systemName: "person")
                        .font(.system(size: 16))
                        .foregroundStyle(.gray)
                    
                    TextField("홍길동", text: $name)
                        .pretendardStyle(by: .Regular, on: .Body, fill: .black)
                        .onChange(of: name) { _, newValue in
                            if newValue.count > characterLimit {
                                name = String(newValue.prefix(characterLimit))
                            }
                        }
                        .autocorrectionDisabled()
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray.opacity(0.1))
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("\(name.count)/15")
                            .pretendardStyle(by: .Light, on: .Caption2, fill: .black.opacity(0.4))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                    }
                }
            }
        }
    }
    
    private var ButtonView: some View {
        GeometryReader { geometry in
            let width = max(geometry.size.width - 72, 0)
            
            HStack(spacing: 8) {
                DismissButton(with: width * 1/4)
                StartButton(with: width * 3/4, disabled: (name.isEmpty || name.count > 15))
                    .disabled(name.isEmpty || name.count > 15)
            }
        }
    }
    
    private var ExplainView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("시작하면, 날마음의 아래 약관에 동의하게 됩니다.")
            }
            HStack(spacing: 0) {
                Text("개인정보처리방침")
                    .underline()
                    .onTapGesture {
                        if let url = URL(string: "https://dorogono.com/products/moodsky/privacy/") {
                            UIApplication.shared.open(url)
                        }
                    }
                Text("과 ")
                Text("서비스이용약관")
                    .underline()
                    .onTapGesture {
                        if let url = URL(string: "https://dorogono.com/products/moodsky/terms_of_service/") {
                            UIApplication.shared.open(url)
                        }
                    }
                Text("입니다.")
            }
        }
        .pretendardStyle(by: .Regular, on: .Caption1, fill: .gray.opacity(0.7))
        .multilineTextAlignment(.center)
    }
    
    private func StartButton(with width: CGFloat, disabled: Bool) -> some View {
        Button {
            userName = name
            onSuccess()
        } label: {
            Text("날마음 시작하기")
                .pretendardStyle(by: .SemiBold, on: .Body, fill: disabled ? .white.opacity(0.7) : .white)
                .frame(width: max(width, 0))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background {
                    if disabled {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.black.gradient.opacity(0.3))
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.black.gradient)
                    }
                }
                .shadow(color: .black.opacity(0.2), radius: 8)
        }
    }
    
    private func DismissButton(with width: CGFloat) -> some View {
        Button {
            onDismiss()
            name = ""
        } label: {
            Text("취소")
                .pretendardStyle(by: .Regular, on: .Body, fill: .white)
                .frame(width: max(width, 0))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.red.gradient)
                }
                .shadow(color: .black.opacity(0.2), radius: 8)
        }
    }
}
