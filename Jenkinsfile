// CodeAlpha DevOps - Tâche 2 : Jenkins Remoting Project
// Démontre la distribution de charge de build entre deux noeuds distants
// (agent-build et agent-test), connectés au contrôleur via SSH Remoting.

pipeline {
    agent none // le contrôleur ne build rien lui-même (sécurité + isolation)

    options {
        timestamps()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '20'))
    }

    stages {

        stage('Build & Tests distribués (exécution en parallèle sur 2 noeuds)') {
            parallel {

                stage('Build - noeud distant "agent-build"') {
                    agent { label 'linux-build' }
                    steps {
                        echo "Étape exécutée sur le noeud distant : ${env.NODE_NAME}"
                        sh 'uname -a'
                        sh 'echo "Compilation du projet (simulation)..." && sleep 2'
                        sh 'echo "Build terminé sur agent-build."'
                    }
                }

                stage('Tests - noeud distant "agent-test"') {
                    agent { label 'linux-test' }
                    steps {
                        echo "Étape exécutée sur le noeud distant : ${env.NODE_NAME}"
                        sh 'uname -a'
                        sh 'echo "Exécution de la suite de tests (simulation)..." && sleep 2'
                        sh 'echo "Tests terminés sur agent-test."'
                    }
                }
            }
        }

        stage('Rapport final') {
            agent { label 'linux-build' }
            steps {
                echo "Agrégation des résultats sur le noeud de build (${env.NODE_NAME})."
                echo "Démonstration réussie : la charge de build a bien été distribuée " +
                     "entre deux noeuds Jenkins distants via SSH Remoting."
            }
        }
    }

    post {
        always {
            echo "Pipeline terminé."
        }
        failure {
            echo "Le pipeline a échoué — vérifier la connectivité SSH vers les noeuds distants " +
                 "(Manage Jenkins > Nodes > [nom du noeud] > Log)."
        }
    }
}
