//
//  GuidelineModel.swift
//  Rabee
//
//  Created by Ferry Dwianta P on 27/07/23.
//

import Foundation

struct GuidelineModel {
    let step: Int
    let title: String
    let description: String
    let state: GuidelineState
    
    static let GuidelineData: [GuidelineModel] = [
        GuidelineModel(step: 1, title: "Pilih Tema Wedding", description: "Konsep atau gaya yang menjadi panduan dalam merancang seluruh acara pernikahan.", state: .current),
        GuidelineModel(step: 2,title: "Pilih Suasana Warna", description: "Warna untuk dekorasi, bunga, pakaian, dan lainnya yang dapat mencerminkan suasana pernikahan.", state: .finished),
        GuidelineModel(step: 3,title: "Pilih Pakaian Pernikahan", description: "Pakaian yang dikenakan oleh pengantin dan/atau tamu undangan dalam sebuah pernikahan.", state: .notFinished),
        GuidelineModel(step: 4,title: "Pilih Moodboard", description: "Konsep utuh dari rancangan pernikahan dalam bentuk papan foto konsep pernikahan.", state: .notFinished),
        
    ]
}
