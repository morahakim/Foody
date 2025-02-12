//
//  LoadingWidget.swift
//  Foody
//
//  Created by mora hakim on 15/12/24.
//

import SwiftUI

public struct LoadingWidget: UIViewRepresentable {
    public typealias UIViewType = UIActivityIndicatorView

    @Binding var isLoading: Bool
    let style: UIActivityIndicatorView.Style

    public init(isLoading: Binding<Bool>, style: UIActivityIndicatorView.Style) {
        self._isLoading = isLoading
        self.style = style
    }

    public func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: self.style)
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if self.isLoading {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
