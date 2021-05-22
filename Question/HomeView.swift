//
//  HomeView.swift
//  ChatView
//
//  Created by 正木脩平 on 2020/12/24.
//

import SwiftUI
import GoogleMobileAds

struct HomeView: View {
    @EnvironmentObject var boolists: boolist

    var body: some View {
        if boolists.loginBool {
            AnonymousView()
        } else {
            
            ZStack {
            
            
                TabView {
                QuestionnairView()
                    .tabItem {
                        Image(systemName: "graduationcap")
                        Text("回答")
                    }.padding(.bottom, 50)
                    
                ListView()
                        .tabItem {
                            Image(systemName: "highlighter")
                            Text("作成")
                        }.padding(.bottom, 50)
                    
                MyListView()
                        .tabItem {
                            Image(systemName: "folder.badge.person.crop")
                            Text("履歴")
                        }
                    
                SettingView()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("その他")
                    }
                }
                VStack {
                    Spacer()
                    AdView().frame( height: 50)
                        .padding(.bottom, 50)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var boolists: boolist {
        let boolists = boolist()
        return boolists
    }
    static var previews: some View {
        HomeView().environmentObject(boolists)
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}

struct AdView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        // 以下は、バナー広告向けのテスト専用広告ユニットIDです。自身の広告ユニットIDと置き換えてください。
        banner.adUnitID = "ca-app-pub-1445585409683022/1975096889"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {
    }
}
