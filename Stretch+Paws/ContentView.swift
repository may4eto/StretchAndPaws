//
//  ContentView.swift
//  Stretch+Paws
//
//  Created by Maya Mircheva on 14/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: DetailView()) {
                    Text("Downward Facing Dog")
                }
            }
            .listStyle(.grouped)
            .navigationBarTitle("Stretch + Paws")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
