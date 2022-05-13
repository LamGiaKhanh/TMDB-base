//
//  AmplifyInitialzer.swift
//  StreamApp
//
//  Created by Phat Le on 15/04/2022.
//

import Core
import Domain

class AmplifyInitialzer: Initializable, EnvironmentProvider {
    @Injected var amazonService: AmazonService

    func performInitialization() {
        amazonService.configAmplify(awsUserPoolId: env.awsUserPoolId,
                                    awsClientId: env.awsClientId,
                                    flowType: .userPasswordAuth)
    }
}
