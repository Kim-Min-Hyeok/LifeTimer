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
                            SettingView()
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
