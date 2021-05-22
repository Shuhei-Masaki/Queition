//
//  ActivityIndicator.swift
//  ChatView
//
//  Created by 正木脩平 on 2021/01/09.
//
import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {
    public var style = UIActivityIndicatorView.Style.medium
    @Binding var animating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if animating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
