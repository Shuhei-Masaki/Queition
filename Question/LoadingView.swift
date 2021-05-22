//
//  LoadingView.swift
//  SavingMoneyApp
//
//  Created by 正木脩平 on 2021/01/09.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    @Binding var title: String
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View{
        ZStack {
            content()
                .blur(radius: isShowing ? 3 : 0)
                .animation(.easeIn)
            
            ZStack {
                VStack {
                    Text(title)
                        .multilineTextAlignment(.center)
                    ActivityIndicator(style: .large, animating: .constant(true))
                }.frame(width: 200, height: 160)
                .compositingGroup()
                .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color(UIColor.systemBackground)))
                .shadow(radius: 6)
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity)
            .animation(.none)
            .background(Color.gray.opacity(0.5))
            .opacity(self.isShowing ? 1 : 0)
            .animation(.easeIn)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct LoadingView_PreViews: PreviewProvider {
    static var previews: some View {
        LoadingView(title: .constant("Loading..."), isShowing: .constant(true)) {
            VStack(alignment: .leading) {
                NavigationView {
                    List {
                        ForEach(0...100, id: \.self) {
                            Text("Constant Exsample \($0)")
                        }
                    }.navigationBarTitle("loading View Demo")
                }
            }
        }
    }
}

