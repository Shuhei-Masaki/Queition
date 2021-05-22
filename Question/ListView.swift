//
//  ListView2.swift
//  ChatView
//
//  Created by 正木脩平 on 2020/12/23.
//

import SwiftUI
import GoogleMobileAds
import FirebaseAuth

struct ListView: View {
    
    @State var user = ""
    @State var theme = ""
    @State var listurl = ""
    @State var applicant = 0
    @State var time = 5
    @State var comment = ""
    @State var correctSelect = ""
    @State var failedSelect1 = ""
    @State var failedSelect2 = ""
    @State var failedSelect3 = ""
    @State var registerToggle = false
    @State var endDate = Date()
    @ObservedObject var listVM = listViewModel()
    @EnvironmentObject var boolists: boolist
    let randomInt = Int.random(in: 1..<6)
    let uid = Auth.auth().currentUser?.uid
    
    @State var isLoading = false
    @State var title = ""
    @State var complete = false
    
    @State var interstitial : GADInterstitial!

    
    var body: some View {
        
        LoadingView(title: $title, isShowing: $isLoading){
            NavigationView{
                if boolists.requestBool == false {
               // if boolists.requestBool {
                    AnswerCheckView()
                } else {
                ZStack {
                    Color(red: 1, green: 1, blue: 0.6)
                        .edgesIgnoringSafeArea(.all)
                    ScrollView {
                        //見出し
                        HStack {
                            Text("入力項目")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .padding(.vertical, 30)
                            Image(systemName: "doc.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(width: 35, height: 35)
                        }
                        Text("⚠️既にリストに掲載している場合、前のデータは削除されます").font(.callout).padding(.bottom)
                        
                        VStack(alignment: .leading){
                            //名前
                            HStack {
                                Text("ニックネーム")
                                    .fontWeight(.bold).padding(.bottom, -15).padding(.leading)
                                Text("必須")
                                    .font(.subheadline)
                                    .foregroundColor(.red).frame(width: 40.0)
                                    .border(Color.red).padding(.bottom, -15).padding(.leading)
                            }
                            TextField("例）タロウ", text: $user)
                                .font(.title3).padding()
                                .frame(height: 50.0)
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                                .padding().padding(.bottom)
                            
                            //アンケート名
                            HStack {
                                Text("アンケート名")
                                    .fontWeight(.bold).padding(.bottom, -15).padding(.leading)
                                Text("必須")
                                    .font(.subheadline)
                                    .foregroundColor(.red).frame(width: 40.0)
                                    .border(Color.red).padding(.bottom, -15).padding(.leading)
                            }
                            TextField("例）〜についての調査", text: $theme)
                                .font(.title3).padding()
                                .frame(height: 50.0)
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                                .padding().padding(.bottom)
                            
                             //アンケートURL
                            HStack {
                                Text("アンケートURL")
                                    .fontWeight(.bold)
                                    .padding(.bottom, -15).padding(.leading)
                                Text("必須")
                                    .font(.subheadline)
                                    .foregroundColor(.red).frame(width: 40.0)
                                    .border(Color.red).padding(.bottom, -15).padding(.leading)
                            }
                            TextField("有効なURLを添付してください", text: $listurl)
                                .font(.title3)
                                .padding()
                                .frame(height: 50.0)
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                                .padding().padding(.bottom)
                        }
                        VStack(alignment: .leading){
                            
                            //募集人数
                            HStack {
                                Text("募集人数")
                                    .fontWeight(.bold)
                                    .padding(.bottom, -15).padding(.leading)
                                Text("必須")
                                    .font(.subheadline)
                                    .foregroundColor(.red).frame(width: 40.0)
                                    .border(Color.red).padding(.bottom, -15).padding(.leading)
                            }
                            Stepper(value: $applicant, in: 0...30, step: 10) {
                                Text("募集人数 : \(applicant)人")
                            }.font(.title3).padding()
                            .frame(height: 50.0)
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                            .padding().padding(.bottom)
                            //所要時間
                            
                            Text("所要時間")
                                .fontWeight(.bold)
                                .padding(.bottom, -15).padding(.leading)
                            Stepper(value: $time, in: 1...10) {
                                Text("所要時間 : 約\(time)分")
                            }.font(.title3).padding()
                            .frame(height: 50.0)
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                            .padding().padding(.bottom)
                            
                            //コメント
                            Text("一言コメント(30字まで表示可能)")
                                    .fontWeight(.bold)
                                    .padding(.bottom, -15).padding(.leading)
                            TextField("入力してください", text: $comment)
                                .font(.title3).padding()
                                .frame(height: 50.0)
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                                .padding().padding(.bottom)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("※以下の質問は25字以内にまとめてください").foregroundColor(.red)
                                .fontWeight(.bold).padding(.bottom).padding(.leading)
                            //正解回答
                            HStack {
                                Text("掲載するアンケートに存在する質問")
                                    .fontWeight(.bold).padding(.bottom, -15).padding(.leading)
                                Text("必須")
                                    .font(.subheadline)
                                    .foregroundColor(.red).frame(width: 40.0)
                                    .border(Color.red).padding(.bottom, -15).padding(.leading)
                            }
                            TextField("入力してください", text: $correctSelect)
                                .font(.title3).padding()
                                .frame(height: 50.0)
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                                .padding().padding(.bottom)
                            //偽回答１
                            HStack {
                                Text("存在しないひっかけ質問１")
                                    .fontWeight(.bold).padding(.bottom, -15).padding(.leading)
                                Text("必須")
                                    .font(.subheadline)
                                    .foregroundColor(.red).frame(width: 40.0)
                                    .border(Color.red).padding(.bottom, -15).padding(.leading)
                            }
                            TextField("入力してください", text: $failedSelect1)
                                .font(.title3).padding()
                                .frame(height: 50.0)
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                                .padding().padding(.bottom)
                            //偽回答２
                            HStack {
                                Text("存在しないひっかけ質問２")
                                    .fontWeight(.bold).padding(.bottom, -15).padding(.leading)
                                Text("必須")
                                    .font(.subheadline)
                                    .foregroundColor(.red).frame(width: 40.0)
                                    .border(Color.red).padding(.bottom, -15).padding(.leading)
                            }
                            TextField("入力してください", text: $failedSelect2)
                                .font(.title3).padding()
                                .frame(height: 50.0)
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                                .padding().padding(.bottom)
                            //偽回答３
                            HStack {
                                Text("存在しないひっかけ質問３")
                                    .fontWeight(.bold).padding(.bottom, -15).padding(.leading)
                                Text("必須")
                                    .font(.subheadline)
                                    .foregroundColor(.red).frame(width: 40.0)
                                    .border(Color.red).padding(.bottom, -15).padding(.leading)
                            }
                            TextField("入力してください", text: $failedSelect3)
                                .font(.title3).padding()
                                .frame(height: 50.0)
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                                .padding().padding(.bottom)
                        }
                        DatePicker("締切日", selection: $endDate,displayedComponents: .date).font(.title3).padding()
                        .frame(height: 50.0)
                        .background(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                        .padding().padding(.bottom)
                        //入力しないと押せない登録ボタンを表示、登録したらfirestoreに表示される
                        ZStack{
                            Text("登録")
                                .frame(width: 200.0, height: 60.0)
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .padding(.top, 30)
                                .opacity(0.5)
                                
                            if user != "" && theme != "" && listurl != "" && applicant != 0 && correctSelect != "" && failedSelect1 != "" && failedSelect2 != "" && failedSelect3 != ""  {
                                Button(action:{
                                    self.registerToggle = true
                                }) {
                                    Text("登録")
                                        .padding()
                                        .frame(width: 200.0, height: 60.0)
                                        .foregroundColor(.white)
                                        .background(Color.gray)
                                        .padding(.top, 30)
                                        .alert(isPresented: $registerToggle) {
                                            Alert(title: Text("警告"),
                                              message: Text("作成完了してよろしいですか"),
                                              primaryButton: .cancel(Text("いいえ")),
                                              secondaryButton: .default(Text("はい"),action: {
                                                self.isLoading = true
                                                self.loadingDemo()
                                              }))
                                        }
                                }
                                Spacer()
                            }
                        }
                        //仕方なく置いてる
                        Spacer().alert(isPresented: $complete){
                            Alert(title: Text("作成完了！"), message: .none,
                                  dismissButton: .default(Text("了解"), action:{
                                    self.answerReset()
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
                    }.navigationBarTitle("アンケート作成", displayMode: .inline)
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    }
    
    
    func loadingDemo() {
        self.title = "作成中..,"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.isLoading = false
            self.reset()
        }
    }
    
    func reset() {
        self.listVM.addMessage(comment: self.comment, user: self.user, theme: self.theme, listurl: self.listurl, time: self.time,applicant:self.applicant, correctSelect: self.correctSelect, failedSelect1: self.failedSelect1, failedSelect2: self.failedSelect2, failedSelect3: self.failedSelect3, endDate: endDate ,report: 0)
        self.user = ""
        self.comment = ""
        self.theme = ""
        self.listurl = ""
        self.time = 5
        self.applicant = 0
        self.correctSelect = ""
        self.failedSelect1 = ""
        self.failedSelect2 = ""
        self.failedSelect3 = ""
        self.complete = true
        self.endDate = Date()
    }
    
    func answerReset() {
        self.boolists.answerNumber = 3
        self.boolists.requestBool = true
    }
}
struct ListView_Previews: PreviewProvider {
    static var boolists: boolist {
        let boolists = boolist()
        return boolists
    }
    static var previews: some View {
        Group {
            ListView(user: "", theme: "", listurl: "", applicant: 0, time: 5, comment: "", listVM:  listViewModel()).environmentObject(boolists)
                .environment(\.locale, Locale(identifier: "ja_JP"))

        }
    }
}
