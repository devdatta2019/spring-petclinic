
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
      - name: centos
        image: centos:latest
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
          container('centos') {
              stage ('Prisma scan') {    
              script {
                  
                  final String url="https://us-west1.cloud.twistlock.com/us-3-159181236/api/v1/scans/download?search=devdatta1987/hello-kaniko:1.3"
                  final String response = sh(script: "curl -k -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiZG11bGd1bmRAaW4uaWJtLmNvbSIsInJvbGUiOiJhZG1pbiIsImdyb3VwcyI6bnVsbCwicm9sZVBlcm1zIjpbWzI1NSwyNTUsMjU1LDI1NSwyNTUsMTI3LDFdLFsyNTUsMjU1LDI1NSwyNTUsMjU1LDEyNywxXV0sInNlc3Npb25UaW1lb3V0U2VjIjo2MDAsInNhYXNUb2tlbiI6ImV5SmhiR2NpT2lKSVV6STFOaUo5LmV5SmhZMk5sYzNOTFpYbEpaQ0k2SW1Zd05HUTNOVEpsTFRJMlptUXROR00wTXkxaU5HVmpMVEJpTVdFNU5tUTJNR0ZrTnlJc0luQnlhWE50WVVsa0lqb2lPREEyTURjNU9UQTBNalk0T1RnNE5ERTJJaXdpWm1seWMzUk1iMmRwYmlJNlptRnNjMlVzSW1semN5STZJbWgwZEhCek9pOHZZWEJwTXk1d2NtbHpiV0ZqYkc5MVpDNXBieUlzSW5KbGMzUnlhV04wSWpvd0xDSnBjMEZqWTJWemMwdGxlVXh2WjJsdUlqcDBjblZsTENKMWMyVnlVbTlzWlZSNWNHVkVaWFJoYVd4eklqcDdJbWhoYzA5dWJIbFNaV0ZrUVdOalpYTnpJanBtWVd4elpYMHNJblZ6WlhKU2IyeGxWSGx3WlU1aGJXVWlPaUpUZVhOMFpXMGdRV1J0YVc0aUxDSnBjMU5UVDFObGMzTnBiMjRpT21aaGJITmxMQ0pzWVhOMFRHOW5hVzVVYVcxbElqb3hOalEzTkRJNE9ESXlOak16TENKMWMyVnlVbTlzWlZSNWNHVkpaQ0k2TVN3aWMyVnNaV04wWldSRGRYTjBiMjFsY2s1aGJXVWlPaUpKYm5SbGNtNWhkR2x2Ym1Gc0lFSjFjMmx1WlhOeklFMWhZMmhwYm1WeklFTnZjbkJ2Y21GMGFXOXVJQzBnTXpVNU5EVTROVE0zTkRJMU5qTXpNRE0zTUNJc0luTmxjM05wYjI1VWFXMWxiM1YwSWpvek1Dd2lkWE5sY2xKdmJHVkpaQ0k2SWprek1HWmpNbU15TFRrNU16WXRORGxsTVMwNE1tWXpMV0kzWW1ZMU1UQXdPV0kzWkNJc0ltaGhjMFJsWm1WdVpHVnlVR1Z5YldsemMybHZibk1pT25SeWRXVXNJbVY0Y0NJNk1UWTBOelF6T0RJM09Dd2lkWE5sY201aGJXVWlPaUprYlhWc1ozVnVaRUJwYmk1cFltMHVZMjl0SWl3aWRYTmxjbEp2YkdWT1lXMWxJam9pVTNsemRHVnRJRUZrYldsdUluMC5PMUlNWWs3c2hDeklFNWljcklNcUdScEZjcTdndVpNb2UtVHg5bWQwOGEwIiwiZXhwIjoxNjQ3NDQxMjc4LCJpc3MiOiJ0d2lzdGxvY2sifQ.Zgj5wISA5-gIvj7pBlvN7pU2X-rWcCEhBnOPJbqWuqI" -s  $url", returnStdout: true).trim()
                  echo response 
              }
          
      }         
  }
}

}
}
