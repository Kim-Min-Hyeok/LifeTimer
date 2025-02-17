//
//  LifeTimerWidgetBundle.swift
//  LifeTimerWidget
//
//  Created by Minhyeok Kim on 2/16/25.
//

import WidgetKit
import SwiftUI

@main
struct LifeTimerWidgetBundle: WidgetBundle {
    var body: some Widget {
        TimerWidget() // ✅ 타이머 위젯
        ProgressWidget() // ✅ 프로그래스바 위젯
//        LifeTimerWidgetControl()
//        LifeTimerWidgetLiveActivity()
    }
}
