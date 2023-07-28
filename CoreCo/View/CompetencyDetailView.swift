//
//  CompetencyDetailView.swift
//  CoreCo
//
//  Created by roger deutsch on 7/21/23.
//

import SwiftUI

struct CompetencyDetailView: View {
    let coreCompetency: CoreCompetency
    @State private var isSelected : Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(){
                    Text(coreCompetency.title)
                        .font(.title)
                        .padding()
                    Text(coreCompetency.description)
                        .font(.title2)
                        .foregroundColor(.blue)
                        .padding()
                        .border(.black)
                        .padding(EdgeInsets.init(top: CGFloat(0), leading: CGFloat(3), bottom: CGFloat(5), trailing: CGFloat(3)))
                    ForEach (coreCompetency.examples, id:\.self){ item in
                        let exampleToggle = ExampleToggle()
                        ExamplesToggleView(example: item, exampleToggle: exampleToggle)
                    }
                    Spacer()
                }
            }
        }
        .toolbar{
            Button("Add Journal Entry"){
                
            }
        }
    }
    
    init(competency: CoreCompetency){
        coreCompetency = competency
    }
    
}

class ExampleToggle : Identifiable, ObservableObject{
    let id = UUID()
    @Published var isToggled: Bool = false
}

struct ExamplesToggleView: View {
    
    var example: String
    @ObservedObject var exampleToggle: ExampleToggle
    
    var body: some View {
        VStack(spacing: 0) {
            Toggle(example, isOn: $exampleToggle.isToggled)
                .onChange(of: exampleToggle.isToggled, perform: {isSelected in
                    print("what up? : \(example) \(isSelected)")
                })
        }
        .padding(.horizontal)
        
        
    }
}

let coreCompetency = CoreCompetency(id: "test-1", title: "test title", description: "This is a good long descript to give you an idea.", examples: ["yada","yada 2","yada 3"], group: "Self Management")

struct CompetencyDetailView_Previews: PreviewProvider {
  
    static var previews: some View {
        CompetencyDetailView(competency: coreCompetency)
        //Text("hello competency!")
    }
}
