//
//  MyListView.swift
//  Questionnair
//
//  Created by 正木脩平 on 2021/02/11.
//

import SwiftUI
import FirebaseAuth
import GoogleMobileAds


struct MyListView: View {
    @ObservedObject var listVM = listViewModel()
    @EnvironmentObject var boolists: boolist
    let uid = Auth.auth().currentUser?.uid
    @State var isShowAlert = false
    @State var completeAlert = false
    @State var interstitial : GADInterstitial!

    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(listVM.comments, id: \.createDate) { i in
                    //1問目のリスト
                    if i.myDocument == uid {
                        MyListModelView(user: i.user, theme: i.theme, comment: i.comment, listurl: i.listurl, time: i.time, applicant: i.applicant, myDocument: i.myDocument, correctSelect: i.correctSelect, failedSelect1: i.failedSelect1, failedSelect2: i.failedSelect2, failedSelect3:i.failedSelect3, createDate: i.createDate.dateValue(), endDate: Calendar.current.date(byAdding: .month, value: 1, to: i.createDate.dateValue())!, uid: uid!)
                        .padding(.vertical, 15)
                        
                        Button(action: {self.isShowAlert.toggle()}) {
                            Text("削除").font(.title2)
                                .frame(width: 130, height: 50)
                                .foregroundColor(.white)
                                .background(Color.gray)
                        }
                        .alert(isPresented: $isShowAlert) {
                           Alert(title: Text(""), message: Text("削除してよろしいですか"),
                                 primaryButton: .default(Text("はい"),
                                 action: {
                                     self.completeAlert = true
                                    listVM.myListDelete(readid: uid!)
                                    if interstitial.isReady {
                                        let root = UIApplication.shared.windows.first?.rootViewController
                                        self.interstitial.present(fromRootViewController: root!)
                                    } else {
                                        print("表示できなかった")
                                    }
                                 }),
                                 secondaryButton: .default(Text("いいえ")))
                        }.onAppear(perform: {
                            self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-1445585409683022/5472750549")
                            let request = GADRequest()
                            self.interstitial.load(request)
                        })
                        .padding(.top, 30)
                    Spacer().alert(isPresented: $completeAlert) {
                     Alert(title: Text(""), message: Text("削除しました"),
                        dismissButton: .default(Text("了解")))
                    }
                    }
                }
            }
            .navigationBarTitle("Myアンケート", displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
struct MyListView_Previews: PreviewProvider {
    static var boolists: boolist {
        let boolists = boolist()
        return boolists
    }
    static var previews: some View {
        MyListView().environmentObject(boolists)
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
