//
//  Project.swift
//  tctManifests
//
//  Created by 조수민 on 2023/07/18.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

let project = Project(
    name: "Network",
    organizationName: Workspace.CommonSetting.organizationName,
    options: .options(),
    packages: [],
    targets: makeTargets()
)

private func makeTargets() -> [Target] {
    
    // MARK: - Network
    
    let networkName = "Network"
    let network = Target.makeTargets(
        name: networkName,
        platform: Workspace.CommonSetting.platform,
        bundleIdReverseDomain: Workspace.CommonSetting.bundleIdReverseDomain,
        deploymentTarget: Workspace.CommonSetting.deploymentTarget,
        targetTypes: [
            .dynamicFramework(
                targetSource: .init(
                    sources: "Targets/\(networkName)/Sources/**",
                    resources: "Targets/\(networkName)/Resources/**"
                )
            )
        ],
        headers: .headers(),
        dependencies: [
            // External
            .External.combineExt,
            .External.combineInterception,
            .External.alamofire,
            .External.moya
        ],
        settings: .settings(
            base: SettingsDictionary()
                .swiftActiveCompilationConditions("$(inherited)")
        )
    )
    
    return network
    
}
