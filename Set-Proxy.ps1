# Set system proxy through registry
function Set-Proxy {
    param (
        [parameter(Mandatory=$True)]
        [String] $proxy)

    $PATH = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

    Set-ItemProperty -LiteralPath "$PATH" -Name "MigrateProxy" -Value "1"
    Set-ItemProperty -LiteralPath "$PATH" -Name "ProxyHttp1.1" -Value "1"
    Set-ItemProperty -LiteralPath "$PATH" -Name "ProxyServer" -Value "$proxy"
    Set-ItemProperty -LiteralPath "$PATH" -Name "ProxyOverride" -Value "<local>"
    Set-ItemProperty -LiteralPath "$PATH" -Name "ProxyEnable" -Value "1"

    $proxypac = (Get-ItemProperty -LiteralPath "$PATH").AutoConfigURL
    Set-ItemProperty -LiteralPath "$PATH" -Name "AutoConfigURL2" -Value "$proxypac"
    Set-ItemProperty -LiteralPath "$PATH" -Name "AutoConfigURL"-Value  ""
}

# Unset Proxy
function Unset-Proxy {
    $PATH = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

    #Remove-ItemProperty -LiteralPath "$PATH" -Name "ProxyHttp1.1"
    Remove-ItemProperty -LiteralPath "$PATH" -Name "ProxyServer"
    Set-ItemProperty -LiteralPath "$PATH" -Name "ProxyOverride" -Value "<local>"
    Set-ItemProperty -LiteralPath "$PATH" -Name "ProxyEnable" -Value "0"

    $proxypac = (Get-ItemProperty -LiteralPath "$PATH").AutoConfigURL2
    Set-ItemProperty -LiteralPath "$PATH" -Name "AutoConfigURL"-Value  "$proxypac"
   #Remove-ItemProperty -LiteralPath "$PATH" -Name "AutoConfigURL2"
}
