//
//  ContentView.swift
//  Rentia
//
//  Created by DAMII on 23/07/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var correo = ""
    @State var password = ""
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
	
    var body: some View {
       
        ZStack {
            Color.cyan
            VStack(alignment: .center, spacing: 16){
                Image("login")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                
                Text("Login").font(.system(.title)).bold()
            
                TextField("Ingrese su correo", text: $correo)
                    .keyboardType(.emailAddress)
                    .padding(8)
                    .background()
                    .cornerRadius(16)
                    .padding(.horizontal,6).onChange(of: correo){oldValue, newValue in
                        //logica para ejecutar cada que se escribe
                    }
                SecureField("Ingrese su contraseña", text: $password)
                    .padding(8)
                    .background(.white)
                    .cornerRadius(16)
                    .padding(.horizontal, 6)
                Button("Iniciar Sesion"){
                    //acciones para hacer
                }.padding()
                    .bold()
                    .background(Color(hue: 0.48, saturation: 0.968, brightness: 0.688))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
            }.frame(width: 300, height: 400).padding().background(.blue)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            	
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
