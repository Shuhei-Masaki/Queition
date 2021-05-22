//
//  SettingView.swift
//  ChatView
//
//  Created by 正木脩平 on 2021/01/13.
//

import SwiftUI
import FirebaseAuth

struct SettingView: View {
    @State var checkSignOut = false
    @State var isShowSignedOut = false
    @EnvironmentObject var boolists: boolist
    var body: some View {
        NavigationView() {
            List {
                //idはポケモンgoになっている。登録したら自分のidに変更する
                Link ("レビュー評価", destination: URL(string: "https://itunes.apple.com/app/id1551533563?mt=8&action=write-review")!)
                Link ("ご意見・ご要望", destination: URL(string: "mailto:opinion.toimprove@Gmail.com")!)
                NavigationLink(destination: ServiceView()) {
                    Text("利用規約")
                }
//                Button(action: {self.checkSignOut = true}) {
//                    Text("サインアウト")
//                }.alert(isPresented: $checkSignOut) {
//                    Alert(title: Text("警告"), message: Text("ログアウトしますか？"),
//                          primaryButton: .default(Text("いいえ")),
//                          secondaryButton: .default(Text("はい"), action: {
//                            self.signOut()
//                          }))
//                }
//                Spacer().alert(isPresented: $isShowSignedOut) {
//                    Alert(title: Text(""), message: Text("ログアウトしました"), dismissButton: .default(Text("OK")))
//                }
            }.foregroundColor(.black).padding(.top).navigationBarTitle("その他")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
//    private func signOut() {
//        do {
//            try Auth.auth().signOut()
//            self.isShowSignedOut = true
//            boolists.loginBool = true
//        } catch let signOutError as NSError {
//            print("SignOut Error: %@", signOutError)
//        }
//    }
}

struct SettingView_Previews: PreviewProvider {
    static var boolists: boolist {
        let boolists = boolist()
        return boolists
    }
    static var previews: some View {
        SettingView().environmentObject(boolists)
    }
}
