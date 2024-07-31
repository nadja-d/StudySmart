//
//  ToDoListView.swift
//  StudySmart
//
//  Created by Nadja Jasmine Donosepoetro on 22/02/24.
//

import SwiftUI

struct ItemModel: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

class ToDoListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [
        ItemModel(title: "Study Cellular Biology", isCompleted: false),
        ItemModel(title: "Review Chemistry topic for 15 minutes", isCompleted: false),
        ItemModel(title: "Create new study guide for Physics", isCompleted: false),
    ]
    
    func addItem(title: String) {
        items.append(ItemModel(title: title, isCompleted: false))
    }
    
    func deleteItem(at index: Int) {
        items.remove(at: index)
    }
    
    func toggleItemCompletion(_ item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
        }
    }
}

struct ToDoListView: View {
    @ObservedObject var viewModel = ToDoListViewModel()
    @State private var isPresentingAddList = false
    @State private var newItemTitle = ""
    
    var body: some View {
            VStack {
                Text("This Week’s To Do List ✅")
                    .font(.title)
                
                Text("\(startOfWeek) \u{2192} \(endOfWeek)")
                    .font(.subheadline)

                
                List {
                    ForEach(viewModel.items) { item in
                        ListRow(viewModel: viewModel, item: item)
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        isPresentingAddList = true
                    }) {
                        Text("Add")
                            .font(.title)
                    }
            )
            .sheet(isPresented: $isPresentingAddList) {
                AddListView(viewModel: viewModel, isPresented: $isPresentingAddList)
            }
        .padding()
    }
    
    private func deleteItems(at offsets: IndexSet) {
        viewModel.deleteItem(at: offsets.first ?? 0)
    }
    
    private var startOfWeek: String {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        guard let startDate = calendar.date(from: startComponents) else { return "" }
        return startDate.formatDate()
    }
    
    private var endOfWeek: String {
        let calendar = Calendar.current
        let endComponents = DateComponents(day: 6)
        guard let endDate = calendar.date(byAdding: endComponents, to: startOfWeekDate) else { return "" }
        return endDate.formatDate()
    }
    
    private var startOfWeekDate: Date {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        return calendar.date(from: startComponents) ?? Date()
    }
}

extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: self)
    }
}

struct AddListView: View {
    @ObservedObject var viewModel: ToDoListViewModel
    @Binding var isPresented: Bool
    @State private var textFieldText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                Button(action: {
                    viewModel.addItem(title: textFieldText)
                    isPresented = false
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.top)
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Add an item to your to-do list")
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
