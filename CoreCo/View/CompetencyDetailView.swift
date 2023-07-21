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
        Text(coreCompetency.description)
    }
    
    init(competency: CoreCompetency){
        coreCompetency = competency
    }
}

struct CompetencyDetailView_Previews: PreviewProvider {
    let coreCompetency = CoreCompetency(id: "test-1", title: "test title", description: "test descr", examples: [], group: "Self Management")
    static var previews: some View {
        // CompetencyDetailView(competency: coreCompetency)
        Text("hello competency!")
    }
}
