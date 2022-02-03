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
    stage('Build Petclinic Java App') {
      git url: 'https://github.com/devdatta2019/spring-petclinic.git', branch: 'main'
        container('maven') {
          sh 'mvn -B -ntp clean package -DskipTests'
          
          
        }
      }
    }
node(POD_LABEL) {
    stage('Test Petclinic Java App') {
      git url: 'https://github.com/devdatta2019/spring-petclinic.git', branch: 'main'
        container('maven') {
          sh 'mvn test'
          
          
        }
      }
    }
    stage('Build Java Image') {
      container('kaniko') {
        stage('Build a Go project') {
          sh '/kaniko/executor --context `pwd` --destination bibinwilson/hello-kaniko:1.0'
            
          
        }
      }
    }
  }
