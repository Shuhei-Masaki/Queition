//
//  ListModelView.swift
//  ChatView
//
//  Created by 正木脩平 on 2021/01/11.
//

import SwiftUI
import GoogleMobileAds

struct MyListModelView: View {
    var user = ""
    var theme = ""
    var comment = ""
    var listurl = ""
    var time = 1
    var applicant = 0
    var myDocument = ""
    var correctSelect = ""
    var failedSelect1 = ""
    var failedSelect2 = ""
    var failedSelect3 = ""
    var bools = true
    var createDate = Date()
    var endDate = Date()
    var report = 0
    var uid = "本人の端末"

    
    let device = UIDevice.current.userInterfaceIdiom
    
    @ObservedObject var listVM = listViewModel()
    @ObservedObject var booler = boolist()
    @EnvironmentObject var boolists: boolist
    
    @State var check = false
    @State var correct = false
    @State var failed = false
    @State var reportCheck = false
    @State var reportSend = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    @State var interstitial : GADInterstitial!

    
    var body: some View {
        
        let graduate = Image(systemName: "graduationcap.fill")
        //ipad用のサイズを設定
        if device == .pad {
            VStack(alignment: .leading) {
                Text("\(graduate)作成者:\(user)").font(.title)
                .padding(.bottom, -5).frame(width: 300, alignment: .leading).lineLimit(1)
                ZStack {
                    Color(red: 1, green: 1, blue: 0.6)
                    VStack(alignment: .leading) {
                        
                        //theme
                        HStack {
                            Text("【題名】\(theme)").font(.title3)
                                .fontWeight(.bold).lineLimit(2)
                        }.frame(width: 400, height: 70, alignment: .leading)
                        
                        //URL
                        if let url = URL(string: listurl) {
                            Link("URL:\(listurl)", destination: url)
                        }
                        //人数・時間
                        HStack {
                            Text("募集人数:\(applicant)人")
                            Spacer()
                            Text("所要時間:約\(time)分")
                        }.padding(.top, 7).foregroundColor(.gray)
                        Divider()
                        
                        //コメント
                        Text("コメント:\(comment)")
                            .font(.subheadline).lineLimit(2)
                            .frame(width: 400, height: 38, alignment: .leading)
                        Divider()
                       
                   
                    //VStack
                    }.padding().lineLimit(1)
                    
                    
                    //colorやframeをつける
                }.frame(width: 440, height: 260)
                .border(LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow, Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing), width: 4)
                .cornerRadius(7)
                Text("締切日:\(endDate, formatter: dateFormatter)").font(.footnote)
                    .frame(width: 440, height: 20, alignment: .trailing)
            }
        }
        //iPhone
        else {
            VStack {
            Text("\(graduate)作成者:\(user)").font(.title2)
                .padding(.bottom, -5).frame(width: 300, alignment: .leading).lineLimit(1)
            
            VStack(alignment: .leading) {
            ZStack {
                Color(red: 1, green: 1, blue: 0.6)
                VStack(alignment: .leading) {
                    
                    //theme
                    HStack {
                        Text("【題名】\(theme)").font(.title3)
                            .fontWeight(.bold).lineLimit(2)
                    }.frame(width: 300, height: 70, alignment: .leading)
                    
                    //URL
                    if let url = URL(string: listurl) {
                        Link("URL:\(listurl)", destination: url)
                    }
                    
                    //人数・時間
                    HStack {
                        Text("募集人数:\(applicant)人")
                        Spacer()
                        Text("所要時間:約\(time)分")
                    }.padding(.top, 7).foregroundColor(.gray)
                    Divider()
                    
                    //コメント
                    Text("コメント:\(comment)")
                        .font(.subheadline).lineLimit(2)
                        .frame(width: 300, height: 38, alignment: .leading)
                    Divider()
                                      
                    
                //VStack
            }.padding().lineLimit(1)
            }
                //colorやframeをつける
            }.frame(width: 320, height: 240)
            .border(LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow, Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing), width: 4)
            .cornerRadius(7)
            Text("締切日:\(endDate, formatter: dateFormatter)").font(.caption)
                .frame(width: 330, height: 20, alignment: .trailing)
                .padding(.trailing, 18)

            }
        }
    }
                                             
    func answer() {
        self.boolists.answerNumber = self.boolists.answerNumber - 1
        listVM.block(myDocument: myDocument, uid: uid)
        if self.boolists.answerNumber == 0 {
            self.boolists.requestBool = false
            self.boolists.missAnswer = 3
        }
    }
    func resetLimit() {
        self.boolists.missAnswer = self.boolists.missAnswer - 1
        listVM.block(myDocument: myDocument, uid: uid)
        if self.boolists.missAnswer == 0 {
        self.boolists.answerNumber = 3
        self.boolists.missAnswer = 3
        }
    }
}

struct MyListModelView_Previews: PreviewProvider {
    static var boolists: boolist {
        let boolists = boolist()
        return boolists
    }
    static var previews: some View {
            MyListModelView(user: "shu", theme: "筋トレについてのアンケート", comment: "33文字みんなやってって言っているのになんでやろうとしないのか俺には正直よくわからない", listurl: "http//apple.com", time: 1, applicant: 0, correctSelect: "これが正解", failedSelect1: "これは不正解", failedSelect2: "これが正解かもね", failedSelect3: "ワンチャン正解")
                
                .environmentObject(boolists)
                .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}

