////
////  RegisterView.swift
////  support
////
////  Created by 正木脩平 on 2021/01/28.
////
//
//import SwiftUI
//import Firebase
//import FirebaseAuth
//
//struct RegisterView: View {
//    @State private var mailAddress = ""
//    @State private var password = ""
//    @State private var passwordConfirm = ""
//
//    @State private var isShowAlert = false
//    @State private var isError = false
//    @State private var errorMessage = ""
//    @State private var service = false
//
//    var body: some View {
//        ZStack {
//            Color(red: 1, green: 0.94, blue: 0.57)
//                .edgesIgnoringSafeArea(.all)
//            HStack {
//                Spacer().frame(width: 50)
//                VStack{
//                    Text("新規登録").font(.title).fontWeight(.bold).padding()
//                    VStack(alignment: .leading) {
//                        Text("メールアドレス").font(.caption).fontWeight(.heavy)
//                            .padding(.bottom, -3)
//                        TextField("メールアドレス", text: $mailAddress).textFieldStyle(RoundedBorderTextFieldStyle())
//                    }
//                    VStack(alignment: .leading) {
//                        Text("パスワード").font(.caption).fontWeight(.bold)
//                            .padding(.bottom, -3)
//                        SecureField("パスワード(数字6桁以上)", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
//                            .keyboardType(.numberPad)
//                    }.padding(.top)
//                    SecureField("パスワード確認", text: $passwordConfirm).textFieldStyle(RoundedBorderTextFieldStyle())
//                        .keyboardType(.numberPad)
//                    HStack{
//                        Button(action:{self.service = true}) {
//                            Text("利用規約").padding(.trailing, -8)
//                        }.sheet(isPresented: $service) {
//                            ServiceView()
//                        }
//                        Text("に同意して").padding(.vertical, 30)
//                    }
//                    Button(action: {
//                        self.errorMessage = ""
//                        if self.mailAddress.isEmpty {
//                            self.errorMessage = "メールアドレスが入力されていません"
//                            self.isError = true
//                            self.isShowAlert = true
//                        } else if self.password.isEmpty {
//                            self.errorMessage = "パスワードが入力されていません"
//                            self.isError = true
//                            self.isShowAlert = true
//                        } else if self.passwordConfirm.isEmpty {
//                            self.errorMessage = "確認パスワードが入力されていません"
//                            self.isError = true
//                            self.isShowAlert = true
//                        } else if self.password.compare(self.passwordConfirm) != .orderedSame {
//                            self.errorMessage = "パスワードと確認パスワードが一致しません"
//                            self.isError = true
//                            self.isShowAlert = true
//                        } else {
//                            self.signUp()
//                        }
//                    }) {
//                        Text("登録").font(.title2)
//                            .frame(width: 130, height: 50)
//                            .foregroundColor(.white)
//                            .background(Color.gray)
//                    }
//                    .alert(isPresented: $isShowAlert) {
//                        if self.isError {
//                            return Alert(title: Text(""), message: Text(self.errorMessage), dismissButton: .destructive(Text("OK"))
//                            )
//                        } else {
//                            return Alert(title: Text(""), message: Text("登録されました"), dismissButton: .default(Text("OK")))
//                        }
//                    }
//                }.autocapitalization(.none)
//                Spacer().frame(width: 50)
//            }
//        }
//    }
//
//    //登録、確認メール、確認後登録完了する関数
//    private func signUp() {
//        Auth.auth().languageCode = "ja_JP"
//        Auth.auth().createUser(withEmail: self.mailAddress, password: self.password) { authResult, error in
//            if let error = error as NSError?, let errorCode = AuthErrorCode(rawValue: error.code) {
//                switch errorCode {
//                case .invalidEmail:
//                    self.errorMessage = "メールアドレスの形式が正しくありません"
//                case .emailAlreadyInUse:
//                    self.errorMessage = "このメールアドレスは既に登録されています"
//                case .weakPassword:
//                    self.errorMessage = "パスワードは６桁以上で入力してください"
//                default:
//                    self.errorMessage = error.domain
//                }
//                self.isError = true
//                self.isShowAlert = true
//            }
//
//            if let _ = authResult?.user {
//                self.isError = false
//                self.isShowAlert = true
//                self.mailAddress = ""
//                self.password = ""
//                self.passwordConfirm = ""
//            }
//        }
//        //ユーザーに確認メールを送る
//        Auth.auth().createUser(withEmail: self.mailAddress, password: self.password) { authResult, error in
//            if let user = authResult?.user {
//                user.sendEmailVerification(completion: { error in
//                    if error == nil {
//                        print("send mail success.")
//                    }
//                })
//            }
//        }
//        //メールを確認したら登録できる関数、しかし確認しなくてもログインできてしまう
//        Auth.auth().signIn(withEmail: self.mailAddress, password: self.password) { authResult, error in
//            if let user = authResult?.user {
//                if user.isEmailVerified {
//                    print("メールアドレス確認済み")
//                } else {
//                    print("メールアドレス未確認")
//                }
//            }
//        }
//    }
//}
//
//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//            .environment(\.locale, Locale(identifier: "ja_JP"))
//    }
//}
