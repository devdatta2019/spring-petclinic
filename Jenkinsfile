
podTemplate(yaml: '''
    apiVersion: v1
    kind: Pod
    spec:
      containers:
      - name: maven
        image: maven:3.8.1-jdk-8
        command:
        - sleep
        args:
        - 99d
      - name: ubuntu
        image: ubuntu:latest
        command:
        - sleep
        args:
        - 99d
      - name: kaniko
        image: gcr.io/kaniko-project/executor:debug
        command:
        - sleep
        args:
        - 9999999
        volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker
      restartPolicy: Never
      volumes:
      - name: kaniko-secret
        secret:
            secretName: dockercred
            items:
            - key: .dockerconfigjson
              path: config.json
''') {
  node(POD_LABEL) {
    stage('Get a Maven project') {
      git url: 'https://github.com/devdatta2019/spring-petclinic.git', branch: 'main'
      container('maven') {
        stage('Build a Maven project') {
          sh 'mvn package'
          
          
        }
      }
    }

    stage('Build Java Image') {
      container('kaniko') {
        stage('Build a Go project') {
          sh '''
            /kaniko/executor --context `pwd` --destination devdatta1987/hello-kaniko:1.5
            
          '''
          }
        }
      }
  
      stage('Scan report') {
          container('ubuntu') {
              stage ('Prisma scan') {    
              script {
                  apt-get install curl
                  final String url="https://us-west1.cloud.twistlock.com/us-3-159181236/api/v1/scans/download?search=devdatta1987/hello-kaniko:1.3"
                  final String response = sh(script: "curl -k -s -u f04d752e-26fd-4c43-b4ec-0b1a96d60ad7 -p Fd541jRnVmlYnrsn3H0Onu+al28= $url", returnStdout: true).trim()
                  echo response 
              }
          
      }         
  }
}

}
}
