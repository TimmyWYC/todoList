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
}



struct ContentView: View{
    @State private var inputText = ""
    @State private var todoList: [TaskObject] = [TaskObject(title: "Code")]
    @State private var categoryImportant = false

    var body: some View{
        NavigationStack{
            HStack{
                HStack{
                    Image(systemName: categoryImportant ? "star.fill" : "star" )
                        .onTapGesture {
                            categoryImportant.toggle()
                            }
                    Text("Important")
                }
                HStack{
                    Image(systemName: categoryImportant ? "circle" : "circle.fill")
                    Text("All")
                }
            }
            List{
                ForEach(todoList, id: \.self){object in
                    if(!categoryImportant){
                        HStack{
                            HStack{
                                Image(systemName: object.isDone ? "checkmark.square" :"square")
                                Text(object.title)
                            }
                            .onTapGesture {
                                if let index  = todoList.firstIndex(of: object){
                                    todoList[index].isDone.toggle()
                                }
                            }
                            Spacer()
                            Image(systemName: object.isImportant ? "star.fill" :"circle")
                                .onTapGesture{
                                    if let index  = todoList.firstIndex(of: object){
                                        todoList[index].isImportant.toggle()
                                    }
                                }
                        }
                    }else if (object.isImportant){
                        HStack{
                            HStack{
                                Image(systemName: object.isDone ? "checkmark.square" :"square")
                                Text(object.title)
                            }
                            .onTapGesture {
                                if let index  = todoList.firstIndex(of: object){
                                    todoList[index].isDone.toggle()
                                }
                            }
                            Spacer()
                            Image(systemName: object.isImportant ? "star.fill" :"circle")
                                .onTapGesture{
                                    if let index  = todoList.firstIndex(of: object){
                                        todoList[index].isImportant.toggle()
                                    }
                                }
                        }
                    }
                }
                .onDelete{indexSet in
                    indexSet.forEach{index in
                        todoList.remove(at: index)
                    }
                }
                TextField("Add task", text: $inputText)
                    .onSubmit{
                        todoList.append(TaskObject(title: inputText))
                        inputText = ""
                    }
            }
            .navigationTitle("Todo List")
        }
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
