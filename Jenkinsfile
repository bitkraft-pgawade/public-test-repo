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
                    def mobileAppChanged = changes.any { it.startsWith('mobileapp/') }

                    // Log folder-specific changes
                    echo "Backend folder changes: ${backendChanged}"
                    echo "Package 1 folder changes: ${package1Changed}"
                    echo "Package 2 folder changes: ${package2Changed}"
                    echo "MobileApp folder changes: ${mobileAppChanged}"

                    // Determine which jobs to echo based on changes
                    def triggeredJobs = []

                    if (package1Changed) {
                        echo "Job to execute: package1-pipeline"
                        echo "Job to execute: mobileapp-pipeline"
                        triggeredJobs.add('pack1')
                    }

                    if (package2Changed) {
                        echo "Job to execute: package2-pipeline"
                        echo "Job to execute: mobileapp-pipeline"
                        triggeredJobs.add('pack2')
                    }

                    if (mobileAppChanged && !triggeredJobs.contains('pack1') && !triggeredJobs.contains('pack2')) {
                        echo "Job to execute: mobileapp-pipeline only"
                    }

                    if (!backendChanged && !package1Changed && !package2Changed && !mobileAppChanged) {
                        echo "No relevant changes detected. Exiting pipeline."
                        currentBuild.result = 'SUCCESS'
                        return
                    }
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
