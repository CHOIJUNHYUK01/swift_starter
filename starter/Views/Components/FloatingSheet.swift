//
//  FloatingSheet.swift
//  starter
//
//  Created by CHOIJUNHYUK on 5/1/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func floatingBottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> () = {},
        @ViewBuilder content: @escaping () -> Content
    ) -> some View{
        self.sheet(
            isPresented: isPresented, onDismiss: onDismiss,
            content: {
                content()
                    .presentationCornerRadius(0)
                    .presentationBackground(.clear)
                    .presentationDragIndicator(.hidden)
                    .background(SheetShadowRemover())
        })
    }
}

fileprivate struct SheetShadowRemover: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            if let uiSheetView = view.viewBeforeWindow {
                for view in uiSheetView.subviews {
                    // Clearing Shadows
                    view.layer.shadowColor = UIColor.clear.cgColor
                }
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

fileprivate extension UIView {
    var viewBeforeWindow: UIView? {
        if let superview, superview is UIWindow {
            return self
        }
        
        return superview?.viewBeforeWindow
    }
}
