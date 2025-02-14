//
//  ContentView.swift
//  LifeTimer
//
//  Created by Minhyeok Kim on 2/4/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // Core data context
    @Environment(\.managedObjectContext) private var viewContext
    
    // 네비게이션 라우터
    @StateObject private var router = NavigationRouter()
    
    @State private var showSplash = true
    @State private var showDisclaimer = true // 면책 조항 Alert
    
    var body: some View {
        ZStack {
            NavigationStack(path: $router.path) {
                // initial Root: HomeView
                HomeView(context: viewContext)
                    .navigationDestination(for: Route.self) { route in
                        switch route.name {
                        case "/":
                            HomeView(context: viewContext)
                        case "/splash":
                            SplashView()
                        case "/surveyIntro":
                            SurveyIntroView()
                        case "/survey":
                            SurveyView(context: viewContext)
                        case "/setting":
                            SettingView(context: viewContext)
                        case "/source":  
                                SourceView()
                        default:
                            Text("알 수 없는 경로: \(route.name)")
                        }
                    }
            }
            .environmentObject(router)
            
            if showSplash {
                SplashView()
                    .transition(.opacity)  // fade-out 전환 효과
                    .zIndex(1)
            }
            
            if showDisclaimer {
                VStack {
                    CustomAlert(
                        title: "⚠️ 면책 조항\n\n이 앱의 결과는 통계적 데이터를 기반으로 한 추정값이며, 의료적 조언을 제공하지 않습니다.\n\n" +
                               "건강 관련 결정을 내리기 전에 반드시 의사의 상담을 받으십시오.\n\n" +
                               "❗ \"아니요\"를 선택하면 앱이 종료됩니다.",
                        confirmAction: {
                            showDisclaimer = false
                        },
                        cancelAction: {
                            exitApp()
                        }
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.5))  // ✅ 배경 어둡게 처리
                .zIndex(2)
            }
        }
        .onAppear() {
            // 앱 실행 후 2초 뒤에 SplashView 제거 (fade-out)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeOut(duration: 0.5)) {
                    showSplash = false
                }
            }
            
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            if let count = try? viewContext.count(for: fetchRequest), count == 0 {
                router.offAll("/surveyIntro")
            }
        }
    }
}
