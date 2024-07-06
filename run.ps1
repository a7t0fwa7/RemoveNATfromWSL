# Function to get the default network adapter name and gateway IP
function Get-NetworkInfo {
    $ipconfig = ipconfig
    $adapter = $null
    $gateway = $null

    foreach ($line in $ipconfig) {
        if ($line -match "Ethernet adapter (.+):") {
            $adapter = $matches[1]
        }
        if ($line -match "Default Gateway[ .]*: ([\d.]+)") {
            $gateway = $matches[1]
            break
        }
    }

    return $adapter, $gateway
}

# Function to find an available IP address in a given subnet
function Get-AvailableIPAddress {
    param (
        [string]$Subnet = "192.168.1.",
        [int]$StartRange = 100,
        [int]$EndRange = 200
    )

    for ($i = $StartRange; $i -le $EndRange; $i++) {
        $ip = $Subnet + $i
        if (!(Test-Connection -ComputerName $ip -Count 1 -Quiet)) {
            return $ip
        }
    }

    throw "No available IP addresses found in the range $Subnet$StartRange to $Subnet$EndRange"
}

# Function to create a network bridge
function Create-NetworkBridge {
    param (
        [string]$AdapterName,
        [string]$WSLAdapterName = "vEthernet (WSL)",
        [string]$BridgeName = "WSLBridge",
        [string]$Subnet = "192.168.1.",
        [int]$PrefixLength = 24,
        [string]$Gateway
    )

    # Find an available IP address
    $IPAddress = Get-AvailableIPAddress -Subnet $Subnet

    # Remove existing network bridge if it exists
    $existingBridge = Get-NetAdapter -Name $BridgeName -ErrorAction SilentlyContinue
    if ($existingBridge) {
        Remove-NetSwitchTeam -Name $BridgeName -Confirm:$false
    }

    # Create a new network bridge
    New-NetSwitchTeam -Name $BridgeName -TeamMembers $AdapterName, $WSLAdapterName

    # Configure the bridge adapter
    New-NetIPAddress -InterfaceAlias $BridgeName -IPAddress $IPAddress -PrefixLength $PrefixLength -DefaultGateway $Gateway
}

# Main script execution
$adapter, $gateway = Get-NetworkInfo

if ($adapter -and $gateway) {
    Write-Output "Detected adapter: $adapter"
    Write-Output "Detected gateway: $gateway"
    Create-NetworkBridge -AdapterName $adapter -Gateway $gateway
    Write-Output "WSL2 bridged networking setup complete."
} else {
    Write-Output "Failed to detect network information"
}