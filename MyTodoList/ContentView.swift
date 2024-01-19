//
//  ContentView.swift
//  TodoList
//
//  Created by Timmy Wong on 2022-10-25.
//

import SwiftUI

struct TaskObject: Hashable{
    let title: String
    var isDone = false
    var isImportant = false
    var isNotImportant = false
}



struct ContentView: View{
    @State private var inputText = ""
    @State private var todoList: [TaskObject] = [TaskObject(title: "Task 1"), TaskObject(title: "Task 2"), TaskObject(title: "Task 3")]
    
    @State private var categoryImportant = false
    @State private var categoryNotImportant = false
    
    @State private var filterList: [TaskObject] = []
    @State private var start = true

    
        
    fileprivate func updateFilter() {
        if categoryImportant{
            filterList = todoList.filter({ element in
                element.isImportant
            })
        }
        else if categoryNotImportant{
            filterList = todoList.filter({ element in
                element.isNotImportant
            })
        }
        else{
            filterList = todoList.filter({ element in
                true
            })
        }
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                HStack {
                    Image(systemName: categoryImportant ? "star.fill" : "star" )
                    Text("Important")
                }
                .onTapGesture {
                    categoryNotImportant = false
                    categoryImportant.toggle()
                    start = false
                    updateFilter()
                }
                HStack {
                    Image(systemName: categoryNotImportant ? "moon.fill" : "moon")
                    Text("Not Important")
                                                
                }
                .onTapGesture {
                    categoryImportant = false
                    categoryNotImportant.toggle()
                    start = false
                    updateFilter()
                }
                HStack {
                    Image(systemName: categoryImportant || categoryNotImportant ? "circle" : "circle.fill")
                    Text("All")
                        
                }
                .onTapGesture {
                    categoryImportant = false
                    categoryNotImportant = false
                    start = false
                    updateFilter()
                }
            }
            List {
                ForEach(start ? todoList : filterList, id: \.self){object in
                    HStack {
                        HStack {
                            Image(systemName: object.isDone ? "checkmark.square" :"square")
                            Text(object.title)
                        }
                        .onTapGesture {
                            if let index  = todoList.firstIndex(of: object) {
                                todoList[index].isDone.toggle()
                            }
                            updateFilter()
                        }
                        Spacer()
                        HStack {
                            Image(systemName: object.isImportant ? "star.fill" :"star")
                                .onTapGesture {
                                    if let index  = todoList.firstIndex(of: object) {
                                        todoList[index].isImportant.toggle()
                                        todoList[index].isNotImportant = false
                                        updateFilter()
                                    }
                                }
                        }
                        HStack {
                            Image(systemName: object.isNotImportant ? "moon.fill" :"moon")
                                .onTapGesture {
                                    if let index  = todoList.firstIndex(of: object) {
                                        todoList[index].isNotImportant.toggle()
                                        todoList[index].isImportant = false
                                        updateFilter()
                                    }
                                }
                        }
                    }
                }
                .onDelete{indexSet in
                    indexSet.forEach{index in
                        todoList.remove(at: index)
                        updateFilter()
                    }
                }
                TextField("Add task", text: $inputText)
                    .onSubmit{
                        todoList.append(TaskObject(title: inputText))
                        inputText = ""
                        updateFilter()
                    }
            
            }
            .navigationTitle("Todo List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
