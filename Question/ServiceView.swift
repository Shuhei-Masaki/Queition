//
//  ServiceView.swift
//  ChatView
//
//  Created by 正木脩平 on 2021/01/13.
//

import SwiftUI

struct ServiceView: View {
    var body: some View {
        //参考サイトhttps://kiyaku.jp/hinagata/gp.html
        //アップデートで追加したいことができたら更新しなくてはならない
        ScrollView {
            //１０項目以上あるからわけた
            VStack {
                VStack(alignment: .leading) {
                    Text("利用規約").font(.title).fontWeight(.black).padding(.vertical)
                    Text("１.この利用規約（以下,「本規約」といいます。)は、「学生アンケートコミュニティ」（以下，「当方」といいます。）がこのアプリ上で提供するサービス（以下,「本サービス」といいます。）について本ユーザーを利用する者（以下,「ユーザー」といいます。）と当方との間の権利義務関係を定めることを目的とし、ユーザーと当方との間の本サービスの利用に関する一切の関係に適用されます。")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("2. ユーザーは、本サービスを利用するにあたり、本利用規約の全文をお読みいただいたうえで、本利用規約に必ず同意いただく必要があります。")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("3. 本利用規約については、ユーザーに対する事前の通知なく、等方が変更できるものとします。本利用規約が変更された場合、当該変更後のユーザーによる本サービスの利用には変更後の本利用規約が適用されるものとし、当該利用により、ユーザーは当該変更に同意したものとみなされます。")
                        .fontWeight(.medium).padding(.vertical)
                }
                    //第１項
                VStack(alignment: .leading) {
                    Text("第1条（適用）").font(.title).fontWeight(.black).padding(.vertical)
                    Text("1.本規約は，ユーザーと当方との間の本サービスの利用に関わる一切の関係に適用されるものとします。")
                        .fontWeight(.medium).padding(.vertical)
                    Text("2.当社は本サービスに関し，本規約のほか，ご利用にあたってのルール等，各種の定め（以下，「個別規定」といいます。）をすることがあります。これら個別規定はその名称のいかんに関わらず，本規約の一部を構成するものとします。")
                        .fontWeight(.medium)
                    Text("3.本規約の規定が前条の個別規定の規定と矛盾する場合には，個別規定において特段の定めなき限り，個別規定の規定が優先されるものとします。").fontWeight(.medium).padding(.vertical)
                }
                //第２項
                VStack(alignment: .leading) {

                    Text("第2条（禁止事項）").font(.title).fontWeight(.black).padding(.vertical)
                    Text("ユーザーは，本サービスの利用にあたり，以下の行為をしてはなりません。")
                        .fontWeight(.medium).padding(.vertical)
                    Text("1.法令または公序良俗に違反する行為")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("2.犯罪行為に関連する行為")
                        .fontWeight(.medium)
                    Text("3.本サービスの内容等，本サービスに含まれる著作権，商標権ほか知的財産権を侵害する行為")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("4.当方，ほかのユーザー，またはその他第三者のサーバーまたはネットワークの機能を破壊したり，妨害したりする行為")
                        .fontWeight(.medium)
                    Text("5.本サービスによって得られた情報を商業的に利用する行為")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("6.当方のサービスの運営を妨害するおそれのある行為")
                        .fontWeight(.medium)
                    Text("7.不正アクセスをし，またはこれを試みる行為")
                        .fontWeight(.medium).padding(.vertical, 10)
                }
                //第２項の続き
                VStack(alignment: .leading) {
                    Text("8.他のユーザーに関する個人情報等を収集または蓄積する行為")
                        .fontWeight(.medium)
                    Text("9.不正な目的を持って本サービスを利用する行為")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("10.本サービスの他のユーザーまたはその他の第三者に不利益，損害，不快感を与える行為")
                        .fontWeight(.medium)
                    Text("11.他のユーザーに成りすます行為")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("12.当方が許諾しない本サービス上での宣伝，広告，勧誘，または営業行為")
                        .fontWeight(.medium)
                    Text("13.面識のない異性との出会いを目的とした行為")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("14.当方のサービスに関連して，反社会的勢力に対して直接または間接に利益を供与する行為")
                        .fontWeight(.medium)
                    Text("15.その他，当方が不適切と判断する行為")
                        .fontWeight(.medium).padding(.vertical, 10)
                }
                //第３項目
                VStack(alignment: .leading) {
                    Text("第3条（本サービスの提供の停止等）").font(.title).fontWeight(.black).padding(.vertical)
                    Text("当方は，以下のいずれかの事由があると判断した場合，ユーザーに事前に通知することなく本サービスの全部または一部の提供を停止または中断することができるものとします。")
                        .fontWeight(.medium).padding(.vertical)
                    Text("1.本サービスにかかるコンピュータシステムの保守点検または更新を行う場合")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("2.地震，落雷，火災，停電または天災などの不可抗力により，本サービスの提供が困難となった場合")
                        .fontWeight(.medium)
                    Text("3.コンピュータまたは通信回線等が事故により停止した場合")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("4.その他，当方が本サービスの提供が困難と判断した場合")
                        .fontWeight(.medium)
                    Text("当方は，本サービスの提供の停止または中断により，ユーザーまたは第三者が被ったいかなる不利益または損害についても，一切の責任を負わないものとします。")
                        .fontWeight(.medium).padding(.vertical)
                }
                //第4項目
                VStack(alignment: .leading) {
                    Text("第4条（保証の否認および免責事項）").font(.title).fontWeight(.black).padding(.vertical)
                    Text("1.当方は，本サービスに事実上または法律上の瑕疵（安全性，信頼性，正確性，完全性，有効性，特定の目的への適合性，セキュリティなどに関する欠陥，エラーやバグ，権利侵害などを含みます。）がないことを明示的にも黙示的にも保証しておりません。")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("2.当方は，本サービスに起因してユーザーに生じたあらゆる損害について一切の責任を負いません。ただし，本サービスに関する当社とユーザーとの間の契約（本規約を含みます。）が消費者契約法に定める消費者契約となる場合，この免責規定は適用されません。")
                        .fontWeight(.medium)
                    Text("3.前項ただし書に定める場合であっても，当方は，当方の過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害のうち特別な事情から生じた損害（当方またはユーザーが損害発生につき予見し，または予見し得た場合を含みます。）について一切の責任を負いません。また，当方の過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害の賠償は，ユーザーから当該損害が発生した月に受領した利用料の額を上限とします。")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("4.当方は，本サービスに関して，ユーザーと他のユーザーまたは第三者との間において生じた取引，連絡または紛争等について一切責任を負いません。")
                        .fontWeight(.medium)
                }
            }
            VStack {
                //第５項目
                VStack(alignment: .leading) {
                    Text("第5条（サービス内容の変更等）").font(.title).fontWeight(.black).padding(.vertical)
                    Text("当方は，必要と判断した場合には，ユーザーに通知することなくいつでも本規約を変更することができるものとします。なお，本規約の変更後，本サービスの利用を開始した場合には，当該ユーザーは変更後の規約に同意したものとみなします。")
                        .fontWeight(.medium).padding(.vertical)
                }
                //第6項目
                VStack(alignment: .leading) {
                    Text("第6条（通知または連絡）").font(.title).fontWeight(.black).padding(.vertical)
                    Text("ユーザーと当方との間の通知または連絡は，当方の定める方法によって行うものとします。当方は,ユーザーから,当方が別途定める方式に従った変更届け出がない限り,現在登録されている連絡先が有効なものとみなして当該連絡先へ通知または連絡を行い,これらは,発信時にユーザーへ到達したものとみなします。")
                        .fontWeight(.medium).padding(.vertical)
                }
                //第7項目
                VStack(alignment: .leading) {
                    Text("第7条（権利義務の譲渡の禁止）").font(.title).fontWeight(.black).padding(.vertical)
                    Text("ユーザーは，当方の書面による事前の承諾なく，利用契約上の地位または本規約に基づく権利もしくは義務を第三者に譲渡し，または担保に提供することはできません。")
                        .fontWeight(.medium).padding(.vertical)
                }
                //第8項目
                VStack(alignment: .leading) {
                    Text("第8条（準拠法・裁判管轄）").font(.title).fontWeight(.black).padding(.vertical)
                    Text("1.本規約の解釈にあたっては，日本法を準拠法とします。")
                        .fontWeight(.medium).padding(.vertical, 10)
                    Text("2.本サービスに関して紛争が生じた場合には，当方の本店所在地を管轄する裁判所を専属的合意管轄とします。")
                        .fontWeight(.medium)
                }
                
            }
        }.padding().frame(width: 340, alignment: .leading).padding(.bottom)
        .background(Color(red: 1, green: 1, blue: 0.6))
        .cornerRadius(40).padding(.bottom)
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
    }
}
