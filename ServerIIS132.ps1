

        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

        Invoke-WebRequest https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi -outfile $env:temp\\WebDeploy_amd64_en-US.msi
        Start-Process $env:temp\\WebDeploy_amd64_en-US.msi -ArgumentList "ADDLOCAL=ALL /qn /norestart LicenseAccepted='0'" -Wait
        
        Add-Type -AssemblyName System.Web

expand-archive -path '.\bin.zip' -destinationpath '.\'


.\SampleWebApplication.deploy.cmd /Y /M:localhost /U:soapuser /P:P@ssword1
        
  exit 0

      
     