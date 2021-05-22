//
//  AnswerCheckView.swift
//  ChatView
//
//  Created by 正木脩平 on 2021/01/08.
//

import SwiftUI

struct AnswerCheckView: View {
    @State var user = ""
    @State var theme = ""
    @State var listurl = ""
    @State var applicant = 0
    @State var time = 1
    @State var comment = ""
    @State var correctSelect = ""
    @State var failedSelect1 = ""
    @State var failedSelect2 = ""
    @State var failedSelect3 = ""
    @State var registerToggle = false
    @ObservedObject var listVM = listViewModel()
    @EnvironmentObject var boolists: boolist
    
    @State var isLoading = false
    @State var title = ""
    @State var complete = false
    @State var check = false

    var body: some View {
        ZStack {
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
                            Stepper(value: $applicant, in: 0...50, step: 10) {
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
                                Text("掲載するアンケートの最後の質問")
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
                                Text("最後の質問に類似したひっかけ質問１")
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
                                Text("類似したひっかけ質問２")
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
                                Text("類似したひっかけ質問３")
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
                            
                            //入力しないと押せない登録ボタンを表示、登録したらfirestoreに表示される
                        ZStack{
                            Text("登録")
                                .frame(width: 200.0, height: 60.0)
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .padding(.top, 30)
                                .opacity(0.5)
                                    
                                
                            }
                    }
            }.opacity(0.6)
            Rectangle().edgesIgnoringSafeArea(.all).opacity(0.6)
            VStack {
                Text("注意").font(.title3)
                    .fontWeight(.bold).padding(.bottom ,10)
                Text("掲載するには\(boolists.answerNumber)人のアンケートに")
                    .frame(width: 260, height: 40, alignment: .center)
                Text("答える必要があります").padding(.top, -12)
            } .frame(width: 290, height: 170, alignment: .center)
            .cornerRadius(100)
            .background(Color.white)
        }
    }
}
 
struct AnswerCheckView_Previews: PreviewProvider {
    static var boolists: boolist {
        let boolists = boolist()
        return boolists
    }
    static var previews: some View {
        Group {
        AnswerCheckView(user: "", theme: "", listurl: "", applicant: 0, time: 1, comment: "", listVM: listViewModel()).environmentObject(boolists)
        }
    }
}

