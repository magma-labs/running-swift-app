//
//  ChildHostingController.swift
//  RunningApp
//
//  Created by Leyaim on 21/09/21.
//

import UIKit
import SwiftUI

struct SecondView: View {
    @State private var wakeUp = Date()
    @State private var kms: String = ""
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = "Red"
    @State private var showDetails = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Distancia")
            HStack {
                TextField("kms",text: $kms).frame(width: 60).padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding()
                Text("Km").font(.system(size: 16))
            }
            
            Text("Finalizar dia").font(.system(size: 14))
            VStack {
                DatePicker("", selection: $wakeUp).fixedSize().frame(width: 230, alignment: .trailing)
            }.padding(.top, 10).padding(.bottom, 10)
            
            Text("Oponente").font(.system(size: 14))
            VStack {
                Picker("Please choose a color", selection: $selectedColor) {
                    ForEach(colors, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            
            HStack {
                Spacer()
                Button("Crear reto") {
                    print("Button pressed!")
                }
                .buttonStyle(WideOrangeButton())
                Spacer()
            }
        }.padding(20)
    }
}

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct WideOrangeButton: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(minWidth: 0,
                   maxWidth: .infinity, maxHeight: 20)
            .foregroundColor(.white)
            .padding()
            .background( RoundedRectangle(cornerRadius: 5.0).fill(Color.blue)
        )
    }
}

class ChildHostingController: UIHostingController<SecondView> {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: SecondView());
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
