//
//  Shapes.swift
//  Bullseye
//
//  Created by 쩡이 on 9/26/21.
//

import SwiftUI

struct Shapes: View {
    @State private var wideShapes = true
    
    var body: some View {
        VStack {
            if !wideShapes {
                Circle()
                    .strokeBorder(.blue, lineWidth: 20.0)
                    .frame(width: 200.0, height: 100.0)
                    .transition(.opacity)
            }
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.blue)
                .frame(width: wideShapes ? 200.0 : 100.0, height: 100.0)
            Capsule()
                .fill(.blue)
                .frame(width: wideShapes ? 200.0 : 100.0, height: 100.0)
            Ellipse()
                .fill(.blue)
                .frame(width: wideShapes ? 200.0 : 100.0, height: 100.0)
            Button(action: {
                withAnimation {
                    wideShapes.toggle()
                }
            }) {
                Text("Animate!")
            }
        }
        .background(Color.green)
    }
}

struct Shapes_Previews: PreviewProvider {
    static var previews: some View {
        Shapes()
    }
}
