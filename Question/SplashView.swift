//
//  SplashView.swift
//  ChatView
//
//  Created by 正木脩平 on 2021/01/17.
//

import SwiftUI
//スプラッシュ画面を作成
struct SplashView: View {
    @State var isActive = false
    @EnvironmentObject var boolists: boolist
    
    
    var body: some View {
        VStack {
            if self.isActive{
                HomeView()
            } else {
                ZStack {
                    Color(red: 1, green: 0.94, blue: 0.57).edgesIgnoringSafeArea(.all)
                    Image("Image").resizable().frame(width: 200, height: 200).scaledToFit()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var boolists: boolist {
        let boolists = boolist()
        return boolists
    }
    static var previews: some View {
        SplashView().environmentObject(boolists)
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
