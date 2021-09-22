//
//  ChildHostingController.swift
//  RunningApp
//
//  Created by Leyaim on 21/09/21.
//

import UIKit
import SwiftUI

struct SecondView: View {
  var body: some View {
      VStack {
          Text("Second View").font(.system(size: 36))
          Text("Loaded by SecondView").font(.system(size: 14))
      }
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
