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

struct AppView: View {
    @State var name: String
    @State var description: String
    @State var image: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(image)
                .resizable()
                .frame(width: 44, height: 44)
                .cornerRadius(8)
                .padding(.vertical, 8)
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                Text(description.localized())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(name: "Delta: Algorithms", description: "delta", image: "Delta")
    }
}
