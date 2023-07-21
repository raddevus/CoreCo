//
//  CompetencyDetailView.swift
//  CoreCo
//
//  Created by roger deutsch on 7/21/23.
//

import SwiftUI

struct CompetencyDetailView: View {
    let coreCompetency: CoreCompetency
    
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
                        ExamplesToggleView(example: item)
                        
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

struct ExamplesToggleView: View {
    
    var example: String
    @State private var exampleToggle = false
    
    var body: some View {
        VStack(spacing: 0) {
            Toggle(example, isOn: $exampleToggle)
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
