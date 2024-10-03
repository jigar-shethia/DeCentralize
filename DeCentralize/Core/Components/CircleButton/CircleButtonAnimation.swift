//
//  CircleButtonAnimation.swift
//  DeCentralize
//
//  Created by Jigar Shethia on 28/08/24.
//

import SwiftUI

struct CircleButtonAnimation: View {
    @Binding var animate: Bool
    
    var body: some View {
      Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeInOut(duration: 1.0): .none)
            
          
    }
}

#Preview {
    CircleButtonAnimation(animate: .constant(true))
}
