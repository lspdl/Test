

        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

        Invoke-WebRequest https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi -outfile $env:temp\\WebDeploy_amd64_en-US.msi
        Start-Process $env:temp\\WebDeploy_amd64_en-US.msi -ArgumentList "ADDLOCAL=ALL /qn /norestart LicenseAccepted='0'" -Wait
        
        Add-Type -AssemblyName System.Web
$user = ""
$token= "k6she33naswodqk4hfy2sytjvalyps2nuylbox344nwpun6z3yxq"
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user,$token)))

$packageuri = "https://microsoft.visualstudio.com/e8efa521-db8e-4531-9cd8-6923807c7e83/_apis/build/builds/20898832/artifacts?artifactName=drop&api-version=5.1&%24format=zip"
$destination= "C:\WindowsAzure\WebApplication.zip"
Invoke-RestMethod -Uri $packageuri -Method Get -ContentType "application/zip; api-version=5.1" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -OutFile $destination

Expand-Archive -LiteralPath C:\WindowsAzure\WebApplication.Zip -DestinationPath C:\WindowsAzure\

$packageuri ="https://microsoft.visualstudio.com/DefaultCollection/e8efa521-db8e-4531-9cd8-6923807c7e83/_apis/git/repositories/928f4906-67f2-4fb6-960e-b8f1128252a4/Items?path=%2FGateway.zip&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=dev%2Fv-shli5%2FTestEv2Build&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1"
$destination= "C:\WindowsAzure\drop\bin\SampleWebApplication.zip"
Invoke-RestMethod -Uri $packageuri -Method Get -ContentType "application/zip; api-version=5.1" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -OutFile $destination


Cd C:\WindowsAzure\drop\bin
.\SampleWebApplication.deploy.cmd /Y /M:localhost /U:soapuser /P:P@ssword1
        
  exit 0

      
     