//
//  ScheduleView.swift
//  StudySmart
//
//  Created by Nadja Jasmine Donosepoetro on 22/02/24.
//

import SwiftUI


struct EventModel: Identifiable {
    let id = UUID()
    var title: String
    var date: Date
    var eventType: EventType
}

enum EventType {
    case studySession
    case examination
}

class ScheduleViewModel: ObservableObject {
    @Published var events: [EventModel] = [
        EventModel(title: "Biology Study Session", date: Date(), eventType: .studySession),
        EventModel(title: "Mathematics Examination", date: Date().addingTimeInterval(86400), eventType: .examination)
    ]
    
    func addEvent(title: String, date: Date, eventType: EventType) {
        events.append(EventModel(title: title, date: date, eventType: eventType))
    }
}

struct ScheduleView: View {
    @ObservedObject var viewModel = ScheduleViewModel()
    @State private var isPresentingAddEvent = false
    @State private var newEventTitle = ""
    @State private var selectedDate = Date()
    @State private var eventType: EventType = .studySession
    
    var body: some View {
            VStack {
                CalendarPicker(selectedDate: $selectedDate)
                    .padding()
                
                List {
                    ForEach(viewModel.events) { event in
                        EventRow(event: event)
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarTitle("Schedule")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        isPresentingAddEvent = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
            )
            .sheet(isPresented: $isPresentingAddEvent) {
                AddEventView(viewModel: viewModel, isPresented: $isPresentingAddEvent, selectedDate: selectedDate)
            }
    }
}

struct CalendarPicker: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
    }
}

struct EventRow: View {
    var event: EventModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                Text(event.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: event.eventType == .studySession ? "book.fill" : "pencil")
                .foregroundColor(event.eventType == .studySession ? .blue : .orange)
                .font(.title2)
        }
        .padding(.vertical, 8)
    }
}

struct AddEventView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    @Binding var isPresented: Bool
    var selectedDate: Date
    @State private var eventTitle = ""
    @State private var eventType: EventType = .studySession
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Event Title", text: $eventTitle)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                Picker("Event Type", selection: $eventType) {
                    Text("Study Session").tag(EventType.studySession)
                    Text("Examination").tag(EventType.examination)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Button(action: {
                    viewModel.addEvent(title: eventTitle, date: selectedDate, eventType: eventType)
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
                .padding()
            }
            .navigationBarTitle("Add Event", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                isPresented = false
            })
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
