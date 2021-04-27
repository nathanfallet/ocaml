/*
*  Copyright (C) 2021 Groupe MINASTE
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program; if not, write to the Free Software Foundation, Inc.,
* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*
*/

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
            if isForceSplitted || geometry.size.height >= 900 {
                HStack(spacing: 0) {
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
    
    var isForceSplitted: Bool {
        #if os(macOS)
        return true
        #else
        return false
        #endif
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
