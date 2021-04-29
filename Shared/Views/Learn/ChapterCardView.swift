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

struct ChapterCardView: View {
    @State var chapter: LearnChapter

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: "doc.text.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 88)
                .frame(maxWidth: .infinity)
            Spacer()
            Text(chapter.title.localized())
                .font(.body)
                .bold()
                .fixedSize(horizontal: false, vertical: true)
            if let desc = chapter.elements.first(where: { $0 is LearnParagraph }) as? LearnParagraph {
                Text(desc.content.localized())
                    .font(.footnote)
                    .lineLimit(2)
            }
        }
        .foregroundColor(.white)
        .padding(.all)
        .frame(width: 200, height: 222)
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(30)
    }
}

struct ChapterCardView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterCardView(chapter: OCamlCourse.content[0].elements[0] as! LearnChapter)
    }
}
