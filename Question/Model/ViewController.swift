//
//  ViewController.swift
//  ChatView
//
//  Created by 正木脩平 on 2020/12/23.
//


import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth


//idとかプロトコルなしで作れるんか。データの項目を配列化するための第一ステップ
struct listDataType {
    //idリストに番号順に並べるため
    var user:String
    var theme: String
    var comment: String
    var listurl:String
    var time:Int
    var applicant:Int
    var myDocument: String
    var correctSelect: String
    var failedSelect1: String
    var failedSelect2: String
    var failedSelect3: String
    var createDate = Timestamp(date: Date())
    var endDate = Timestamp(date: Date())
    var report: Int
    var block:[String]
}


class listViewModel: ObservableObject {

    @Published var comments = [listDataType]()
    let db = Firestore.firestore().collection("lists")
    //snaoshotのやり方
    init() {
        
        db.order(by: "createDate", descending: true).addSnapshotListener() { [self] (snap, error) in
            guard let documents = snap?.documents else {
                //localizedDescriptionはFoundationの機能？
                print("No Documents")
                return
            }
            //これでViewが更新されたら直ちに変更できるようになった。まじで嬉しい。
            self.comments = documents.map { (snap) -> listDataType in
                let data = snap.data()
                
                let comment = data["comment"] as? String ?? ""
                let user = data["user"] as? String ?? ""
                let theme = data["theme"] as? String ?? ""
                let listurl = data["listurl"] as? String ?? ""
                let time = data["time"] as? Int ?? 1
                let applicant = data["applicant"] as? Int ?? 0
                let myDocument = data["myDocument"] as? String ?? ""
                let correctSelect = data["correctSelect"] as? String ?? ""
                let failedSelect1 = data["failedSelect1"] as? String ?? ""
                let failedSelect2 = data["failedSelect2"] as? String ?? ""
                let failedSelect3 = data["failedSelect3"] as? String ?? ""
                let report = data["report"] as? Int ?? 0
                let block = data["block"] as? [String] ?? [""]
                let createDate = data["createDate"] as? Timestamp ?? Timestamp(seconds: 2020, nanoseconds: 11)
                let endDate = data["endDate"] as? Timestamp ?? Timestamp(seconds: 2022, nanoseconds: 1)
                
                if endDate.dateValue() <= Date() {
                    db.document(myDocument).delete(){ err in
                        if let err = err {
                            print("削除しっぱーい: \(err)")
                        } else {
                            print("削除完了ですです！")
                        }
                    }
                }
                
                
                //listDataTypeだと後で反復して使うからめちゃだるくわざわざ変数iで宣言している。
                let i = listDataType(user: user, theme: theme, comment:comment, listurl: listurl, time: time, applicant: applicant, myDocument: myDocument, correctSelect: correctSelect, failedSelect1: failedSelect1, failedSelect2: failedSelect2, failedSelect3: failedSelect3, createDate: createDate, endDate: endDate, report: report, block: block)
                return i
            }
        }
    }
    
      //チャットを送信した時の操作内容、メッセージ内容と登録名が表示される。これなら理解できそー
    func addMessage(comment: String, user: String, theme: String, listurl:String, time:Int, applicant:Int, correctSelect: String, failedSelect1: String, failedSelect2: String, failedSelect3: String, endDate: Date, report: Int) {
        //保存したファイルを呼び出す操作だと思う
        
        let data = [
            "comment":comment,
            "user":user,
            "theme": theme,
            "listurl":listurl,
            "time":time,
            "applicant":applicant,
            "correctSelect": correctSelect,
            "failedSelect1": failedSelect1,
            "failedSelect2": failedSelect2,
            "failedSelect3": failedSelect3,
            "createDate": Timestamp(date: Date()),
            "endDate": Timestamp(date: endDate),
            "report":report
        ] as [String : Any]
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.document(uid).setData(data)
        db.document(uid).updateData([
            "myDocument" : "\(uid)"
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document succeessfully update")
            }
        }
    }
    //ここで回答、通報したリストは消える
    func block(myDocument: String, uid: String) {
        db.document(myDocument).updateData(["block": FieldValue.arrayUnion(["\(uid)"])
        ])
    }
    
    func fieldUpdate(readid: String,applicant: Int) {
        
        let washingtonRef = db.document(readid)
        if applicant > 1 {
            washingtonRef.updateData([
                "applicant": applicant - 1
            ]) { err in
                if let err = err {
                    print("変更しっぱーい: \(err)")
                } else {
                    print("変更完了ですです！")
                }
            }
        }
        if applicant <= 1 {
            db.document(readid).delete() { err in
                if let err = err {
                    print("削除しっぱーい: \(err)")
                } else {
                    print("削除完了ですです！")
                }
            }
        }
    }
    
    func myListDelete(readid: String) {
        db.document(readid).delete() { err in
            if let err = err {
                print("削除しっぱーい: \(err)")
            } else {
                print("削除完了ですです！")
            }
        }
    }
    
    func reportUpdate(readid: String, report: Int) {
        
        let washingtonRef = db.document(readid)
        if report < 20{
            washingtonRef.updateData([
                "report": report + 1
            ]) { err in
                if let err = err {
                    print("変更しっぱーい: \(err)")
                } else {
                    print("変更完了ですです！")
                }
            }
        }
        if report >= 20 {
            db.document(readid).delete() { err in
                if let err = err {
                    print("削除しっぱーい: \(err)")
                } else {
                    print("削除完了ですです！")
                }
            }
        }
    }
}



//回答したらユーザーの画面のListから消える仕組み、x人回答しないとアンケートが作成できない仕組み、間違え続けると必要回答数がリセットされる仕組みを作る
class boolist: ObservableObject {
    //答えが正解か間違いかを表示する目的
    @Published var answerBool: Bool {
        didSet {
            UserDefaults.standard.set(answerBool,forKey: "answerBool")
        }
    }
    //X人回答したらアンケートを掲載できるようにする目的
    @Published var requestBool: Bool {
        didSet {
            UserDefaults.standard.set(requestBool,forKey: "requestBool")
        }
    }
    //アンケートを掲載するためにあと何人答えるかを表示する目的
    @Published var answerNumber: Int {
        didSet {
            UserDefaults.standard.set(answerNumber,forKey: "answerNumber")
        }
    }
    //間違えられる回数を表示する目的
    @Published var missAnswer: Int {
        didSet {
            UserDefaults.standard.set(missAnswer,forKey: "missAnswer")
        }
    }
    //利用規約の同意
    @Published var loginBool: Bool {
        didSet {
            UserDefaults.standard.set(loginBool,forKey: "loginBool")
        }
    }
    init() {
        //boolとintegerではデフォルト値が設定できないためにobjectを使用した。
        answerBool = UserDefaults.standard.object(forKey: "answerBool") as? Bool ?? false
        requestBool = UserDefaults.standard.object(forKey: "requestBool") as? Bool ?? true
        answerNumber = UserDefaults.standard.object(forKey: "answerNumber") as? Int ?? 3
        missAnswer = UserDefaults.standard.object(forKey: "missAnswer") as? Int ?? 2
        loginBool = UserDefaults.standard.object(forKey: "loginBool") as? Bool ?? true
    }
}
