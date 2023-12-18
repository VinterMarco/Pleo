//
//  CustomTabMenuView.swift
//  Pleo
//
//  Created by Vinter Marco on 18.12.2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case message
    case person
    case leaf
    case gearshape
}

struct CustomTabMenuView: View {
    @Binding var selectedTab: Tab
      private var fillImage: String {
          selectedTab.rawValue + ".fill"
      }
      private var tabColor: Color {
          switch selectedTab {
          case .house:
              return .blue
          case .message:
              return .indigo
          case .person:
              return .purple
          case .leaf:
              return .green
          case .gearshape:
              return .orange
          }
      }
    
    var body: some View {
        HStack {
                       ForEach(Tab.allCases, id: \.rawValue) { tab in
                           Spacer()
                           Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                               .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                               .foregroundColor(tab == selectedTab ? tabColor : .gray)
                               .font(.system(size: 20))
                               .onTapGesture {
                                   withAnimation(.easeInOut(duration: 0.1)) {
                                       selectedTab = tab
                                   }
                               }
                           Spacer()
                       }
                   }
                   .frame(width: nil, height: 60)
                   .background(.thinMaterial)
                   .cornerRadius(20)
                   .padding()
               }
    
}

#Preview {
    CustomTabMenuView(selectedTab: .constant(.house))
}




// old

//struct CustomTabMenuView: View {
//    var body: some View {
//        TabView {
//            Text("1")
//                .badge(2)
//                .tabItem {
//                    Label("Received", systemImage: "tray.and.arrow.down.fill")
//                }
//            Text("1")
//                .tabItem {
//                    Label("Sent", systemImage: "tray.and.arrow.up.fill")
//                }
//            Text("1")
//                .badge("!")
//                .tabItem {
//                    Label("Account", systemImage: "person.crop.circle.fill")
//                }
//        }
//    }
//}
//
//#Preview {
//    CustomTabMenuView()
//}
