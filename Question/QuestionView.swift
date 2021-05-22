//
//  QuestionnairView.swift
//  ChatView
//
//  Created by 正木脩平 on 2020/12/24.
//

import SwiftUI
import FirebaseAuth

struct QuestionnairView: View {
    @ObservedObject var listVM = listViewModel()
    @EnvironmentObject var boolists: boolist
    let uid = Auth.auth().currentUser?.uid ?? ""
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                ForEach(listVM.comments, id: \.createDate) { i in
                    //1問目のリスト
                    if !i.block.contains(uid) {
                        ListModelView(user: i.user, theme: i.theme, comment: i.comment, listurl: i.listurl, time: i.time, applicant: i.applicant, myDocument: i.myDocument, correctSelect: i.correctSelect, failedSelect1: i.failedSelect1, failedSelect2: i.failedSelect2, failedSelect3:i.failedSelect3, createDate: i.createDate.dateValue(), endDate: i.endDate.dateValue(), uid: uid)
                        .padding(.bottom, 15)
                    }
                }
            }.padding(.top, 20)
            .navigationBarTitle("アンケート一覧", displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct QuestionnairView_Previews: PreviewProvider {
    static var boolists: boolist {
        let boolists = boolist()
        return boolists
    }
    static var previews: some View {
        QuestionnairView().environmentObject(boolists)
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
