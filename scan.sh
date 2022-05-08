#!/bin/bash   

export  results

echo -e "Image Name : $IMAGENAME"
               echo -e "TAG : $TAG"
               echo -e "Triggered the Scan"
               TOKEN=$(curl -v -s -k -H "Content-Type: application/json" -d "{\"username\":\"$USERNAME\", \"password\":\"$PASSWORD\"}" https://us-west1.cloud.twistlock.com/us-3-159181236/api/v1/authenticate | jq -r .TOKEN)

               echo -e "Triggered the Scan"
               
               curl -k -v  -H "Authorization: Bearer $TOKEN"  'Content-Type:Application/json' -X POST https://us-west1.cloud.twistlock.com/us-3-159181236/api/v1/registry/scan   

               until  [ "$(curl  -k -H "Authorization: Bearer $TOKEN" "https://us-west1.cloud.twistlock.com/us-3-159181236/api/v1/registry?limit=1&search=index.docker.io/devdatta1987/hello-kaniko/$IMAGENAME:$TAG" -s )" != "null" ]
                do    echo -e "Checking for Results of $IMAGENAME:$TAG"
                      sleep 2
                done
                
                results="$(curl  -k -H "Authorization: Bearer $TOKEN" "https://us-west1.cloud.twistlock.com/us-3-159181236/api/v1/registry?limit=1&search=inde.docker.io/devdatta1987/hello-kaniko/$IMAGENAME:$TAG" -s )"
               
                echo "$results" | python3 -c 'import sys, json; print(json.load(sys.stdin)[0]["vulnerabilityDistribution"])'             