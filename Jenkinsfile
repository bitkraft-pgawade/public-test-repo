
pipeline {
    agent { label 'built-in' }

    triggers {
        pollSCM('H/10 * * * *') // Polls SCM every 10 minutes
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Detect Changes') {
            steps {
                script {
                    // Collect all changed files from the current build
                    def changes = []
                    for (changeSet in currentBuild.changeSets) {
                        for (entry in changeSet.items) {
                            changes.addAll(entry.affectedPaths)
                        }
                    }
                    
                    // Log the detected changes
                    echo "Detected changes: ${changes}"

                    // Initialize flags for folder changes
                    def backendChanged = changes.any { it.startsWith('backend/') }
                    def package1Changed = changes.any { it.startsWith('pack1/') }
                    def package2Changed = changes.any { it.startsWith('pack2/') }

                    // Log folder-specific changes
                    echo "Backend folder changes: ${backendChanged}"
                    echo "Package 1 folder changes: ${package1Changed}"
                    echo "Package 2 folder changes: ${package2Changed}"

                    // Trigger backend pipeline if changes are in the backend folder
                    // if (backendChanged) {
                    //     build(job: 'backend-pipeline', parameters: [string(name: 'BRANCH', value: env.BRANCH_NAME)])
                    // }

                    // // Trigger package1 pipeline if changes are in the package1 folder
                    // if (package1Changed) {
                    //     build(job: 'package1-pipeline', parameters: [string(name: 'BRANCH', value: env.BRANCH_NAME)])
                    // }

                    // // Trigger package2 pipeline if changes are in the package2 folder
                    // if (package2Changed) {
                    //     build(job: 'package2-pipeline', parameters: [string(name: 'BRANCH', value: env.BRANCH_NAME)])
                    // }

                    // // Stop the pipeline if no relevant changes are detected
                    // if (!backendChanged && !package1Changed && !package2Changed) {
                    //     echo "No relevant changes detected. Exiting pipeline."
                    //     currentBuild.result = 'SUCCESS'
                    //     return
                    // }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
