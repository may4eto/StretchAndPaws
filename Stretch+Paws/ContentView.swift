//
//  ContentView.swift
//  Stretch+Paws
//
//  Created by Maya Mircheva on 14/06/2022.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITableView.appearance().backgroundColor = UIColor(named: "Secondary")
    }
    let poses = Poses()
    @State var isActive:Bool = false
    var body: some View {
        VStack {
            if self.isActive {
                NavigationView {
                List(poses.poseData) {pose in
                    NavigationLink(destination: DetailView(pose: pose)) {
                        Image(pose.icon)
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text(pose.name)
                            .fontWeight(.medium)
                            .font(.title3)
                            .padding(.leading, 20)
                    }
                    .padding(5)
                    .listRowBackground(Color("Secondary"))
                }
                .listStyle(.grouped)
                .navigationBarTitle("Stretch + Paws")
                }
            } else {
                SplashView()
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(Animation.easeInOut(duration: 2)) {
                    isActive = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SplashView: View {
    var body: some View {
        ZStack {
            Color("Secondary").ignoresSafeArea()
            VStack {
                Image("Cat-3")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color("HightLight"))
            }
        }
    }
}
