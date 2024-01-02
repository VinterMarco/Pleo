//
//  SavingsView.swift
//  Pleo
//
//  Created by Vinter Marco on 02.01.2024.
//

import SwiftUI

struct SavingsView: View {
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    VStack(spacing: 0) {
                        Color.blue.ignoresSafeArea(edges: .top)
                        Color.white.ignoresSafeArea(edges: .top)
                        Color.white.ignoresSafeArea(edges: .top)
                        Color.white.ignoresSafeArea(edges: .top)
                    }
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Hello, Marco 🚀")
                            .fontDesign(.rounded)
                            .font(.system(size: 23))
                            .foregroundColor(.white)
                            .bold()
                            
                        Text("Savings")
                            .foregroundStyle(.white)
                            .font(.title).fontWeight(.medium)
                            .bold()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Create a new goal!")
                                .fontWidth(Font.Width.expanded)
                                .font(.system(size: 28))
                                .bold()
                            HStack {
                                Text("5 dreams in the making")
                                    .offset(y : -3)
                                    .font(.system(size: 22))
                                Button {
                                    // more code to come
                                } label: {
                                    Image(systemName: "plus")
                                        .padding(18)
                                        .font(.system(size: geometry.size.width < 600 ? 24 : 40))
                                        .bold()
                                        .background(.blue)
                                        .clipShape(.circle)
                                        .foregroundColor(.white)
                                        .shadow(color: .blue, radius: 2)
                                        .offset(x : 7)
                                }
                            }
                        }
                        .padding(0)
                        .frame(width: geometry.size.width - 80)

                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 20) {
//                            ScrollView {
//                                VStack {
//                                    Text("Saving 1")
//                                    Text("Saving 2")
//                                    Text("Saving 3")
//                                    Text("Saving 4")
//                                    Text("Saving 5")
//                                    Text("Saving 6")
//                                    Text("Saving 7")
//                                }
//                                .frame(maxWidth: .infinity)
//                            }
                            SavingsListView()
                        }
                        
                        .frame(width: geometry.size.width - 50, height : 420)
//                        .background(.green)

                        
                    }
                    // end of main vstack
                    .shadow(color: .gray, radius: 5)

                    .padding(0)
                    .frame(width: geometry.size.width - 32, height: geometry.size.height - 10)
//                    .background(.red)
                }
            }
            .navigationTitle("Savings")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SavingsView()
}
