////
////  SignInView.swift
////  support
////
////  Created by 正木脩平 on 2021/01/28.
////
//
//import SwiftUI
//import FirebaseAuth
//
//struct SignInView: View {
//    
//    @State private var mailAddress = ""
//    @State private var password = ""
//    
//    @State private var isShowAlert = false
//    @State private var isError = false
//    @State private var errorMessage = ""
//    
//    @State private var isShowSignedOut = false
//    
//    @ObservedObject var listVM = listViewModel()
//    @EnvironmentObject var boolists: boolist
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Color(red: 1, green: 0.94, blue: 0.57)
//                    .edgesIgnoringSafeArea(.all)
//                HStack {
//                    Spacer().frame(width: 50)
//                    VStack(spacing: 16) {
//                        Text("ログイン画面").font(.title).fontWeight(.bold).padding()
//                        VStack(alignment: .leading) {
//                            Text("メールアドレス").font(.caption).fontWeight(.heavy)
//                                .padding(.bottom, -3)
//                            TextField("メールアドレス", text: $mailAddress).textFieldStyle(RoundedBorderTextFieldStyle())
//                                
//                        }
//                        VStack(alignment: .leading) {
//                            Text("パスワード").font(.caption).fontWeight(.bold)
//                                .padding(.bottom, -3)
//                            SecureField("パスワード", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
//                                .keyboardType(.numberPad)
//                                
//                        }.padding(.top)
//                        Button(action: {
//                            self.errorMessage = ""
//                            if self.mailAddress.isEmpty {
//                                self.errorMessage = "メールアドレスが入力されていません"
//                                self.isError = true
//                                self.isShowAlert = true
//                            } else if self.password.isEmpty {
//                                self.errorMessage = "パスワードが入力されていません"
//                                self.isError = true
//                                self.isShowAlert = true
//                            } else {
//                                self.signIn()
//                            }
//                        }) {
//                            Text("ログイン")
//                        }
//                        .alert(isPresented: $isShowAlert) {
//                            if self.isError {
//                                return Alert(title: Text(""), message: Text(self.errorMessage), dismissButton: .destructive(Text("OK"))
//                                )
//                            } else {
//                                return Alert(title: Text(""), message: Text("ログインしました"), dismissButton: .default(Text("OK")))
//                            }
//                        }
//                        HStack {
//                            Text("新規登録は").padding(.trailing, -8)
//                            NavigationLink(destination: RegisterView()) {
//                                Text("コチラ")
//                            }
//                        }.padding()
//                    }
//                    Spacer().frame(width: 50)
//                }.autocapitalization(.none)
//            }
//        }.navigationViewStyle(StackNavigationViewStyle())
//    }
//    
//    //サインインする、それぞれのエラーコードを記述
//    private func signIn() {
//        Auth.auth().signIn(withEmail: self.mailAddress, password: self.password) { authResult, error in
//            if authResult?.user != nil {
//                self.isShowAlert = true
//                self.isError = false
//                boolists.loginBool = false
//            } else {
//                self.isShowAlert = true
//                self.isError = true
//                if let error = error as NSError?, let errorCode = AuthErrorCode(rawValue: error.code) {
//                    switch errorCode {
//                    case .invalidEmail:
//                        self.errorMessage = "メールアドレスの形式が正しくありません"
//                    case .userNotFound, .wrongPassword:
//                        self.errorMessage = "メールアドレス、またはパスワードが間違っています"
//                    case .userDisabled:
//                        self.errorMessage = "このユーザーアカウントは無効化されています"
//                    default:
//                        self.errorMessage = error.domain
//                    }
//                    
//                    self.isError = true
//                    self.isShowAlert = true
//                }
//            }
//        }
//    }
//}
//struct SignInView_Previews: PreviewProvider {
//    static var boolists: boolist {
//        let boolists = boolist()
//        return boolists
//    }
//    static var previews: some View {
//        SignInView().environmentObject(boolists)
//            .environment(\.locale, Locale(identifier: "ja_JP"))
//
//    }
//}
