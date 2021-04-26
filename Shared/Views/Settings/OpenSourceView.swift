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

struct OpenSourceView: View {
    var body: some View {
        List {
            Section() {
                OpenSourceRepositoryView(user: "GroupeMINASTE", repo: "OCaml-iOS")
            }
            Section(header: Text("opensource_swiftpackages")) {
                OpenSourceRepositoryView(user: "twostraws", repo: "Sourceful")
                OpenSourceRepositoryView(user: "onevcat", repo: "Kingfisher")
            }
            Section(header: Text("opensource_others")) {
                OpenSourceRepositoryView(user: "ocsigen", repo: "js_of_ocaml")
            }
        }
        .navigationTitle("opensource")
        .listStyle(InsetGroupedListStyle())
    }
}

struct OpenSourceView_Previews: PreviewProvider {
    static var previews: some View {
        OpenSourceView()
    }
}
