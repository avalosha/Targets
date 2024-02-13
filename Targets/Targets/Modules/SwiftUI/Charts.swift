//
//  Charts.swift
//  Targets
//
//  Created by Sferea-Lider on 12/02/24.
//

import SwiftUI

struct Charts: View {
    
    weak var navigationController: UINavigationController?
    
    var body: some View {
        VStack {
            HStack {
                Text("SwiftUI Screen")
                    .bold()
                    .font(.system(size: 21.0))
            }
            
            Spacer()
                .frame(width: 1, height: 74, alignment: .bottom)
            
            VStack(alignment: .center) {
                Button(action: {
                    navigationController?.popViewController(animated: true)
                }) {
                    Text("Navigate to UIKit Screen")
                        .font(.system(size: 21.0))
                        .bold()
                        .frame(width: UIScreen.main.bounds.width, height: 10, alignment: .center)
                }
            }
            
            Spacer()
                .frame(width: 1, height: 105, alignment: .bottom)
        }.navigationBarHidden(true)
    }
    
}

#Preview {
    Charts()
}
