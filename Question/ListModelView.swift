//
//  ListModelView.swift
//  ChatView
//
//  Created by 正木脩平 on 2021/01/11.
//

import SwiftUI
import GoogleMobileAds

struct ListModelView: View {
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
    
    var a = "ca-app-pub-1445585409683022/5472750549"
    
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
                       
                    //docid読み取り問題
                        HStack {
                            Button(action: {reportCheck.toggle()
                        }) {
                            Text("通報")
                        }.actionSheet(isPresented: $reportCheck) {
                            ActionSheet(title: Text("通報内容"),
                                     buttons: [
                                        .default(Text("選択肢のミス"), action: {
                                            reportSend = true
                                            self.listVM.reportUpdate(readid: self.myDocument, report: self.report)
                                        }),
                                        .default(Text("無効なURLの使用"), action: {
                                            reportSend = true
                                            self.listVM.reportUpdate(readid: self.myDocument, report: self.report)
                                        }),
                                        .default(Text("不快な内容"), action: {
                                            reportSend = true
                                            self.listVM.reportUpdate(readid: self.myDocument, report: self.report)
                                        }),
                                        .default(Text("その他"), action: {
                                            reportSend = true
                                            self.listVM.reportUpdate(readid: self.myDocument, report: self.report)
                                        })])
                    }
                            Spacer().alert(isPresented: $reportSend){
                                Alert(title: Text("通報完了！"), message: .none,
                                      dismissButton: .default(Text("了解"),action: {
                                        listVM.block(myDocument: myDocument, uid: uid)
                                      }))}
                            
                            Button(action: {check.toggle()
                        }) {
                            Text("回答完了")
                        }.actionSheet(isPresented: $check) {
                            ActionSheet(title: Text("確認"),
                                     message: Text("実際に聞かれた質問は次のうちどれ？"),
                                     buttons: [
                                        .default(Text(self.correctSelect), action: {
                                            self.correct = true
                                            self.listVM.fieldUpdate(readid: self.myDocument, applicant: self.applicant)
                                        }),
                                        .default(Text(self.failedSelect1), action: {
                                            self.failed = true
                                        }),
                                        .default(Text(self.failedSelect2), action: {
                                            self.failed = true
                                        }),
                                        .default(Text(self.failedSelect3), action: {
                                            self.failed = true
                                        })].shuffled())
                    }
                        }
                    //VStack
                    }.padding().lineLimit(1)
                    if boolists.answerNumber >= 2 {
                        //正解した場合のアラート
                        if boolists.requestBool {
                            Spacer().alert(isPresented: $correct) {
                                Alert(title: Text("正解です！"),message: Text("作成可能まであと\(self.boolists.answerNumber - 1)つです"), dismissButton: .default(Text("了解"),  action: {
                                    self.answer()
                                }))
                            }
                        }
                        } else {
                            Spacer().alert(isPresented: $correct) {
                                Alert(title: Text("通知"),
                                      message: Text("作成できるようになりました！"), dismissButton: .default(Text("了解"),  action: {
                                        
                                        self.answer()
                                      
                            }))
                            }
                        }
                    
                    if boolists.requestBool {
                    //アラート入れるとこなくて仕方なくここにぶち込んだ
                    if self.boolists.missAnswer >= 2 {
                        Spacer().alert(isPresented: $failed) {
                            Alert(title: Text("不正解です"),                                   message:Text("あと\(self.boolists.missAnswer - 1)回間違えると必要回答数が　　　　　リセットされます"), dismissButton: .default(Text("了解"),  action: {
                                self.resetLimit()
                                if interstitial.isReady {
                                    let root = UIApplication.shared.windows.first?.rootViewController
                                    self.interstitial.present(fromRootViewController: root!)
                                } else {
                                    print("表示できなかった")
                                }
                            }))
                        }
                        .onAppear(perform: {
                            self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-1445585409683022/5472750549")
                            let request = GADRequest()
                            self.interstitial.load(request)
                        })
                    } else {
                        Spacer().alert(isPresented: $failed) {
                            Alert(title: Text("リセットされました").foregroundColor(.red),
                                message:Text("あと\(self.boolists.missAnswer + 2)回間違えると必要回答数が　　　　　リセットされます"), dismissButton: .default(Text("了解"),  action: {
                                    self.resetLimit()
                                    if interstitial.isReady {
                                        let root = UIApplication.shared.windows.first?.rootViewController
                                        self.interstitial.present(fromRootViewController: root!)
                                    } else {
                                        print("表示できなかった")
                                    }
                            }))
                        }
                        .onAppear(perform: {
                            self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-1445585409683022/5472750549")
                            let request = GADRequest()
                            self.interstitial.load(request)
                        })
                    }
                    } else {
                        Spacer().alert(isPresented: $failed) {
                            Alert(title: Text("不正解です").foregroundColor(.red),
                                  message:Text(""), dismissButton: .default(Text("了解"),  action: {
                                    if interstitial.isReady {
                                        let root = UIApplication.shared.windows.first?.rootViewController
                                        self.interstitial.present(fromRootViewController: root!)
                                    } else {
                                        print("表示できなかった")
                                    }
                        }))}
                            .onAppear(perform: {
                            self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-1445585409683022/5472750549")
                            let request = GADRequest()
                            self.interstitial.load(request)
                        })
                    }
                    
                    
                    //colorやframeをつける
                }.frame(width: 440, height: 260)
                .border(LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow, Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing), width: 4)
                .cornerRadius(7)
                Text("締切日\(endDate, formatter: dateFormatter)").font(.footnote)
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
                   
                //docid読み取り問題
                    HStack {
                        Button(action: {reportCheck.toggle()}) {
                        Text("通報")
                    }.actionSheet(isPresented: $reportCheck) {
                        ActionSheet(title: Text("通報内容"),
                                 buttons: [
                                    .default(Text("選択肢のミス"), action: {
                                        reportSend = true
                                        self.listVM.reportUpdate(readid: self.myDocument, report: self.report)
                                    }),
                                    .default(Text("無効なURLの使用"), action: {
                                        reportSend = true
                                        self.listVM.reportUpdate(readid: self.myDocument, report: self.report)
                                    }),
                                    .default(Text("不快な内容"), action: {
                                        reportSend = true
                                        self.listVM.reportUpdate(readid: self.myDocument, report: self.report)
                                    }),
                                    .default(Text("その他"), action: {
                                        reportSend = true
                                        self.listVM.reportUpdate(readid: self.myDocument, report: self.report)
                                    }),
                                    .cancel(Text("キャンセル"))
                                 ])
                }
                        Spacer().alert(isPresented: $reportSend){
                            Alert(title: Text("通報完了！"), message: .none,
                                  dismissButton: .default(Text("了解"),action: {
                                    listVM.block(myDocument: myDocument, uid: uid)
                                  }))}
                        Button(action: {check.toggle()
                    }) {
                        Text("回答完了")
                    }.actionSheet(isPresented: $check) {
                        ActionSheet(title: Text("確認"),
                                 message: Text("実際に聞かれた質問は次のうちどれ？"),
                                 buttons: [
                                    .default(Text(self.correctSelect), action: {
                                        self.correct = true
                                        self.listVM.fieldUpdate(readid: self.myDocument, applicant: self.applicant)
                                    }),
                                    .default(Text(self.failedSelect1), action: {
                                        self.failed = true
                                    }),
                                    .default(Text(self.failedSelect2), action: {
                                        self.failed = true
                                    }),
                                    .default(Text(self.failedSelect3), action: {
                                        self.failed = true
                                    }),
                                    .cancel(Text("キャンセル"))                             ].shuffled())
                }
                    }
                    
                //VStack
            }.padding().lineLimit(1)
                
            
                //正解した場合のアラート
                if boolists.answerNumber >= 2 {
                    if boolists.requestBool {
                    Spacer().alert(isPresented: $correct) {
                        Alert(title: Text("正解です！"),message: Text("作成可能まであと\(self.boolists.answerNumber - 1)つです"), dismissButton: .default(Text("了解"),  action: {
                            self.answer()
                        }))
                    }
                }
                } else {
                    Spacer().alert(isPresented: $correct) {
                        Alert(title: Text("通知"),
                              message: Text("作成できるようになりました！"), dismissButton: .default(Text("了解"),  action: {
                                self.answer()
                        }))
                    }
                }
            
                if boolists.requestBool {
                //アラート入れるとこなくて仕方なくここにぶち込んだ
                if self.boolists.missAnswer >= 2 {
                    Spacer().alert(isPresented: $failed) {
                        Alert(title: Text("不正解です"),                                   message:Text("あと\(self.boolists.missAnswer - 1)回間違えると必要回答数が　　　　　リセットされます"), dismissButton: .default(Text("了解"),  action: {
                            self.resetLimit()
                            if interstitial.isReady {
                                let root = UIApplication.shared.windows.first?.rootViewController
                                self.interstitial.present(fromRootViewController: root!)
                            } else {
                                print("表示できなかった")
                            }
                        }))
                    }
                    .onAppear(perform: {
                        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-1445585409683022/5472750549")
                        let request = GADRequest()
                        self.interstitial.load(request)
                    })
                } else {
                    Spacer().alert(isPresented: $failed) {
                        Alert(title: Text("リセットされました").foregroundColor(.red),
                              message:Text("あと\(self.boolists.missAnswer + 2)回間違えると必要回答数が　　　　　リセットされます"), dismissButton: .default(Text("了解"),  action: {
                                self.resetLimit()
                                if interstitial.isReady {
                                    let root = UIApplication.shared.windows.first?.rootViewController
                                    self.interstitial.present(fromRootViewController: root!)
                                } else {
                                    print("表示できなかった")
                                }
                        }))
                    }
                    .onAppear(perform: {
                        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-1445585409683022/5472750549")
                        let request = GADRequest()
                        self.interstitial.load(request)
                    })
                }
                } else {
                    Spacer().alert(isPresented: $failed) {
                        Alert(title: Text("不正解です").foregroundColor(.red),
                              message:Text(""), dismissButton: .default(Text("了解"),  action: {

                                if interstitial.isReady {
                                    let root = UIApplication.shared.windows.first?.rootViewController
                                    self.interstitial.present(fromRootViewController: root!)
                                } else {
                                    print("表示できなかった")
                                }
                    }))}
                        .onAppear(perform: {
                        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-1445585409683022/5472750549")
                        let request = GADRequest()
                        self.interstitial.load(request)
                    })
                }
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

struct ListModelView_Previews: PreviewProvider {
    static var boolists: boolist {
        let boolists = boolist()
        return boolists
    }
    static var previews: some View {
            ListModelView(user: "shu", theme: "筋トレについてのアンケート", comment: "33文字みんなやってって言っているのになんでやろうとしないのか俺には正直よくわからない", listurl: "http//apple.com", time: 1, applicant: 0, correctSelect: "これが正解", failedSelect1: "これは不正解", failedSelect2: "これが正解かもね", failedSelect3: "ワンチャン正解")
                
                .environmentObject(boolists)
                .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}

