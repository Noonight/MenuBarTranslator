//
//  DictionaryCellView.swift
//  MenuBarTranslator
//
//  Created by Aiur on 02.04.2021.
//

import SwiftUI

struct DictionaryCellView: View {
    
    let savedWord: SavedWord
    
    let updateBtnAction: (() -> ())
    let deleteBtnAction: (() -> ())
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text(savedWord.en)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                    .foregroundColor(.black)
                Spacer()
                Text(savedWord.ru)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                    .foregroundColor(.black)
            }
            Divider()
                .background(Color.black)
            HStack {
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "chevron.down.circle.fill")
                            .foregroundColor(.black)
                    }
                    Text("\(String(savedWord.repeatCounter))")
                        .foregroundColor(.black)
                    Button(action: {
                        
                    }) {
                        Image(systemName: "chevron.up.circle.fill")
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                Text("\(DateHelper.format(date: Date()))")
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    updateBtnAction()
                }) {
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.black)
                }
                Button(action: {
                    deleteBtnAction()
                }) {
                    Image(systemName: "trash.circle.fill")
                        .foregroundColor(.black)
                }
            }
        }
        .padding(4)
        .background(Color.secondary)
        .cornerRadius(5)
//        .contextMenu {
//            Text("Hello from context")
//        }
    }
}

struct DictionaryCellView_Previews: PreviewProvider {
    static var previews: some View {
        //        DictionaryCellView()
        Text("empty")
    }
}
