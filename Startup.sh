#!/bin/bash
ROOTDIRECTORY=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
cd "$ROOTDIRECTORY"/JmeterPublish.Models
echo "The current directory is : Expecting Model folder"
pwd
echo cma@2020# | sudo -S  dotnet build
cd "$ROOTDIRECTORY"/JmeterPublish.DAL
echo "The current directory is : Expecting DAL folder"
pwd
echo cma@2020# | sudo -S  dotnet build
cd "$ROOTDIRECTORY"/
echo cma@2020# | sudo -S  rm -f "$ROOTDIRECTORY"/JmeterPublish.sln
echo cma@2020# | sudo -S  dotnet new sln --name JmeterPublish
echo cma@2020# | sudo -S  dotnet sln add "$ROOTDIRECTORY"/JmeterPublish.Models/JmeterPublish.Models.csproj
echo cma@2020# | sudo -S  dotnet sln add "$ROOTDIRECTORY"/JmeterPublish.DAL/JmeterPublish.DAL.csproj



                    cd "$ROOTDIRECTORY"/JmeterPublishWebApi
                    echo cma@2020# | sudo -S  dotnet build
                    echo cma@2020# | sudo -S  dotnet publish -o "$ROOTDIRECTORY"/Publish/WebApi
cd "$ROOTDIRECTORY"
                cd "$ROOTDIRECTORY"/Admin
                echo cma@2020# | sudo -S  dotnet build
                echo cma@2020# | sudo -S  dotnet publish -o "$ROOTDIRECTORY"/Publish/Admin
                echo cma@2020# | sudo -S  mkdir "$ROOTDIRECTORY"/Publish/Admin/wwwroot/uploads
                echo cma@2020# | sudo -S  cp /home/ubuntu/Automaton/AutomatonClient/wwwroot/BackupFiles/JmeterPublish/AdminUploads/*.* "$ROOTDIRECTORY"/Publish/Admin/wwwroot/uploads


echo "Setting up the Publish Evnrionment"
                        cd /home/ubuntu/Automaton/AutomatonClient/wwwroot/PublishedFiles
                        echo cma@2020# | sudo -S  chown -R ubuntu JmeterPublish
                        cd "$ROOTDIRECTORY"
                        echo cma@2020# | sudo -S  rm -f /etc/nginx/sites-enabled/tdevstaging
                        echo cma@2020# | sudo -S  rm -f /etc/supervisor/conf.d/JmeterPublishWebApi.conf
                        echo cma@2020# | sudo -S  rm -f /etc/supervisor/conf.d/JmeterPublishClient.conf
                        echo cma@2020# | sudo -S  rm -f /etc/supervisor/conf.d/JmeterPublishAdmin.conf
                        echo cma@2020# | sudo -S  cp "$ROOTDIRECTORY"/PublishRequisites/*.conf /etc/supervisor/conf.d/
                        echo cma@2020# | sudo -S  cp "$ROOTDIRECTORY"/PublishRequisites/tdevstaging /etc/nginx/sites-enabled/
                        echo cma@2020# | sudo -S  supervisorctl reread
                        echo cma@2020# | sudo -S  supervisorctl update
                        echo cma@2020# | sudo -S  supervisorctl restart JmeterPublishWebApi
                        echo cma@2020# | sudo -S  supervisorctl restart JmeterPublishClient
                        echo cma@2020# | sudo -S  supervisorctl restart JmeterPublishAdmin 
                        echo cma@2020# | sudo -S  service nginx reload
curl -v --header "Connection: keep-alive" "https://tdev-stg.craftmyapp.in/ContactUs/sentPublishedNotification?projectid=4fc61a77-b6df-4667-af4f-135d9f23e95b"
sudo -s /home/ubuntu/Automaton/AutomatonClient/wwwroot/git.sh JmeterPublish "2025-06-12 10:06" https://tdevstaging:glpat-th-pYrPKiyNYzdoQMfN-@devgit.craftmyapp.in/tdevstaging/JmeterPublish tdevstaging glpat-th-pYrPKiyNYzdoQMfN-

