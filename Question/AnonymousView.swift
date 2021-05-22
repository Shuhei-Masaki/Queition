//
//  AnonymousView.swift
//  Question
//
//  Created by 正木脩平 on 2021/03/30.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AnonymousView: View {
    @EnvironmentObject var boolists: boolist
    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.6).edgesIgnoringSafeArea(.all)
            VStack{
                Spacer().frame(height: 50)
                ServiceView()
                Text("利用規約に同意して").foregroundColor(.blue).padding()
                Button(action: {
                    anonymous()
                    boolists.loginBool = false
                })
                    {
                    Text("始める").font(.title2)
                        .frame(width: 130, height: 50)
                        .foregroundColor(.white)
                        .background(Color.gray)
                }
                Spacer().frame(height: 50)
            }
          
        }
        
    }
    //匿名ログイン
    private func anonymous() {
    Auth.auth().signInAnonymously() { (authResult, error) in
        if error == nil {
            print("ログインできてない")
        }
    }
  }
}

struct AnonymousView_Previews: PreviewProvider {
    static var boolists: boolist {
        let boolists = boolist()
        return boolists
    }
    static var previews: some View {
        AnonymousView().environmentObject(boolists)
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
