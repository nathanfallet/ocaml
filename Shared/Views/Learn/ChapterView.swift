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

struct ChapterView: View {
    @State var chapter: LearnChapter

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(chapter.elements, id: \.id) { element in
                    if let title = element as? LearnTitle {
                        Text(title.content.localized())
                            .font(.title2)
                    } else if let paragraph = element as? LearnParagraph {
                        Text(paragraph.content.localized())
                    } else if let code = element as? LearnCode {
                        CodeEditorView(text: .constant(code.content), readOnly: true)
                            .frame(height: code.height())
                    }
                }
            }
            .padding()
            .navigationTitle(chapter.title.localized())
        }
    }
}

struct ChapterView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterView(chapter: OCamlCourse.content[0].elements[0] as! LearnChapter)
    }
}
