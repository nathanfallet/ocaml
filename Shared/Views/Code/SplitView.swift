//
//  SplitView.swift
//  OCaml
//
//  Created by Nathan FALLET on 25/04/2021.
//

import SwiftUI

struct SplitView<LeftView: View, RightView: View>: View {
    @Binding var showRightView: Bool
    
    var leftView: LeftView
    var rightView: RightView
    
    init(
        @ViewBuilder leftView: () -> LeftView,
        @ViewBuilder rightView: () -> RightView,
        showRightView: Binding<Bool>
    ) {
        self.leftView = leftView()
        self.rightView = rightView()
        self._showRightView = showRightView
    }
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height >= 900 {
                HStack {
                    leftView
                        .frame(
                            minWidth: 0, maxWidth: .infinity,
                            minHeight: 0, maxHeight: .infinity
                        )
                    rightView
                        .frame(
                            minWidth: 0, maxWidth: .infinity,
                            minHeight: 0, maxHeight: .infinity
                        )
                        .frame(
                            width: geometry.size.width / 2
                        )
                }
            } else {
                Group {
                    leftView
                    NavigationLink(
                        destination: rightView,
                        isActive: $showRightView
                    ) {}
                }
            }
        }
    }
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView(leftView: {
            Text("Left")
        }, rightView: {
            Text("Right")
        }, showRightView: .constant(false))
        .previewDevice("iPad (8th generation)")
    }
}
