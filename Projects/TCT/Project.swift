//
//  Project.swift
//  tctManifests
//
//  Created by 조수민 on 2023/07/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Target Name

let appName = "App"
let appTestName = "\(appName)Tests"
let appTargetReference = TargetReference(stringLiteral: appName)
let appTestTargetReference = TargetReference(stringLiteral: appTestName)

// MARK: - Target Bundle

let bundleID = "$(BUNDLE_ID)"
let testBundleID = "$(BUNDLE_ID)Tests"

// MARK: - Project

let project = Project(
    name: "TCT",
    organizationName: Workspace.CommonSetting.organizationName,
    options: .options(),
    targets: makeAppTargets(
        appName: appName,
        appTestName: appTestName,
        bundleID: bundleID,
        testBundleID: testBundleID
    ),
    schemes: [
        .init(
            name: "App",
            shared: true,
            hidden: false,
            buildAction: .init(
                targets: [
                    appTargetReference
                ]
            ),
            testAction: .targets(
                [
                    TestableTarget(target: appTestTargetReference)
                ],
                configuration: .debug
            ),
            runAction: .runAction(configuration: .debug),
            archiveAction: .archiveAction(configuration: .release),
            profileAction: .profileAction(configuration: .release),
            analyzeAction: .analyzeAction(configuration: .debug)
        )
    ],
    fileHeaderTemplate: nil,
    additionalFiles: [],
    resourceSynthesizers: .default
)

// MARK: - Target

private func makeAppTargets(
    appName: String,
    appTestName: String,
    bundleID: String,
    testBundleID: String
) -> [Target] {
    
    // MARK: - App
    
    let appTarget = Target(
        name: appName,
        platform: Workspace.CommonSetting.platform,
        product: .app,
        productName: nil,
        bundleId: bundleID,
        deploymentTarget: Workspace.CommonSetting.deploymentTarget,
        infoPlist: .extendingDefault(
            with: Workspace.CommonSetting.infoPlist.merging(
                [
                    // Info.plist override merging
                    "CFBundleDisplayName": "$(BUNDLE_DISPLAY_NAME)",
                    "CFBundleVersion": "$(BUNDLE_VERSION)",
                    "CFBundleShortVersionString": "$(BUNDLE_SHORT_VERSION_STRING)",
                    "CFBundleURLTypes": [
                        [
                            "CFBundleURLSchemes": [
                                "o1link",
                            ],
                        ],
                        [
                            "CFBundleURLSchemes": [
                                "$(BUNDLE_ID)",
                            ],
                        ],
                    ]
                ],
                uniquingKeysWith: { (lhs, rhs) in rhs }
            )
        ),
        sources: [
            // Sources
            "Targets/\(appName)/Sources/**"
        ],
        resources: [
            // Resources
            "Targets/\(appName)/Resources/**"
        ],
        dependencies: [
            // External
            .External.combineExt,
            .External.kingfisher,
            .External.modernRIBs,
            .External.combineInterception,
            .External.moya,
            .External.then,
            .External.snapKit,
            
            // Network
            .Network.network
        ]
    )
    
    return [
        appTarget
    ]
    
}
