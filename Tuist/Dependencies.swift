//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 조수민 on 2023/07/18.
//

import ProjectDescription

/// 프로젝트 외부 종속성
let dependencies = Dependencies(
    carthage: [
        /// CombineExtension
        .github(path: "https://github.com/CombineCommunity/CombineExt.git", requirement: .upToNext("1.8.1")),
        /// Kingfisher
        .github(path: "https://github.com/onevcat/Kingfisher", requirement: .upToNext("7.0.0"))
    ],
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            /// ModernRIBs
            .remote(url: "https://github.com/DevYeom/ModernRIBs.git", requirement: .upToNextMajor(from: "1.0.2")),
            /// CombineInterception
            .remote(url: "https://github.com/chorim/CombineInterception.git", requirement: .upToNextMajor(from: "0.1.0")),
            /// Moya
            .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.0")),
            /// Then
            .remote(url: "https://github.com/devxoul/Then.git", requirement: .upToNextMajor(from: "2.7.0")),
            /// SnapKit
            .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.6.0"))
        ],
        // 'Mach-O Type' static framework -> dynamic framework 설정
        //
        // 여러 타켓에 종속되는 라이브러리는 'dynamic framework' 처리
        productTypes: [
            // 'CombineInterception'
            "CombineInterception": .framework,
            
            // 'Moya'
            "Alamofire": .framework,
            "Moya": .framework,
            "CombineMoya": .framework,
            
            // 'Then'
            "Then": .framework
        ]
    ),
    platforms: [.iOS]
)
