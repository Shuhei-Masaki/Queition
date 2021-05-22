//
//  ContentView.swift
//  ChatView
//
//  Created by 正木脩平 on 2020/12/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var boolists: boolist
    var body: some View {
        
        SplashView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var boolists: boolist {
        let boolists = boolist()
        return boolists
    }
    static var previews: some View {
        ContentView()
            .environmentObject(boolists)
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
