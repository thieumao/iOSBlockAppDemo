//
//  ContentView.swift
//  Worklog
//
//  Created by Mobile Programming  on 21/08/23.
//

import SwiftUI
import DeviceActivity
import FamilyControls

struct ContentView: View {
    @StateObject var model = MyModel.shared
    @State var isPresented = false
    
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")

    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
               of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )
    
    
    var body: some View {
//        ZStack {
//
//        }
        DeviceActivityReport(context, filter: filter)
        Button("Select Apps to Discourage") {
            isPresented = true
        }
        .familyActivityPicker(isPresented: $isPresented, selection: $model.selectionToDiscourage)
        Button("Start Monitoring") {
            model.initiateMonitoring()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
