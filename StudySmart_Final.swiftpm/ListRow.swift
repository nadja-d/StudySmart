//
//  ListRow.swift
//  StudySmart
//
//  Created by Nadja Jasmine Donosepoetro on 22/02/24.
//

import SwiftUI

struct ListRow: View {
    @ObservedObject var viewModel: ToDoListViewModel
    let item: ItemModel
    
    var body: some View {
        Button(action: {
            viewModel.toggleItemCompletion(item)
        }) {
            HStack {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.isCompleted ? .green : .gray)
                Text(item.title)
                    .foregroundColor(.black)
                Spacer()
            }
        }
    }
}
