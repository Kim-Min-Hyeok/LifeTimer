//
//  LifeTimerWidgetLiveActivity.swift
//  LifeTimerWidget
//
//  Created by Minhyeok Kim on 2/16/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LifeTimerWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct LifeTimerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LifeTimerWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LifeTimerWidgetAttributes {
    fileprivate static var preview: LifeTimerWidgetAttributes {
        LifeTimerWidgetAttributes(name: "World")
    }
}

extension LifeTimerWidgetAttributes.ContentState {
    fileprivate static var smiley: LifeTimerWidgetAttributes.ContentState {
        LifeTimerWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: LifeTimerWidgetAttributes.ContentState {
         LifeTimerWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: LifeTimerWidgetAttributes.preview) {
   LifeTimerWidgetLiveActivity()
} contentStates: {
    LifeTimerWidgetAttributes.ContentState.smiley
    LifeTimerWidgetAttributes.ContentState.starEyes
}
