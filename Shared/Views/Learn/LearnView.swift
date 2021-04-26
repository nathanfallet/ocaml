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

struct LearnView: View {
    var body: some View {
        ScrollView {
            ForEach(OCamlCourse.content, id: \.title) { section in
                VStack(alignment: .leading) {
                    Text(section.title.localized())
                        .font(.title2)
                        .padding([.top, .leading, .trailing])
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(section.elements, id: \.title) { element in
                                if let chapter = element as? LearnChapter {
                                    NavigationLink(destination: ChapterView(chapter: chapter)) {
                                        ChapterCardView(chapter: chapter)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationTitle("learn")
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
