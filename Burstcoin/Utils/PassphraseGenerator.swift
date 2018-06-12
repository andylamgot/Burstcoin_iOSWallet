//
//  PassphraseGenerator.swift
//  Burstcoin
//
//  Created by Andy Prock on 6/9/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import Foundation

struct PassphraseGenerator {
  let words: [String]
  var seed: Int

  init(seed: Int? = Int(time(nil))) {
    // taken from https://github.com/first20hours/google-10000-english/blob/master/google-10000-english-usa-no-swears-medium.txt
    let url = Bundle.main.url(forResource: "Words", withExtension: "plist")!
    let soundsData = try! Data(contentsOf: url)

    self.words = try! PropertyListSerialization.propertyList(from: soundsData, options: [], format: nil) as! [String]
    self.seed = seed!
  }
  
  public func generatePassPhrase() -> [String] {
    // seed with given seed if seed was given, yep
    srand48(seed)
    
    var words : [String] = []
    for _ in 0..<12 {
      let randomIndex = Int(Double(self.words.count) * drand48() - 0.5)
      words.append(self.words[randomIndex])
    }

    return words
  }
}
