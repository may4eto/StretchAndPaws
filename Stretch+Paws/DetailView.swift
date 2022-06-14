//
//  DetailView.swift
//  Stretch+Paws
//
//  Created by Maya Mircheva on 14/06/2022.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        ZStack {
            Color("Secondary").ignoresSafeArea()
            Text("Purrrfect!")
                .font(.title)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
