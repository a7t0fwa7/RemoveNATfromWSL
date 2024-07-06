
# WSL2 Bridged Networking Setup Script

This repository contains a PowerShell script to remove NAT from WSL2 and set up bridged networking. By following the steps outlined in this script, you can configure your WSL2 instance to have an IP address on the same subnet as your host machine, allowing for better network integration and connectivity.

## Benefits in General

1. **Improved Network Integration**: By using bridged networking, your WSL2 instance will have an IP address on the same subnet as your host machine, making it easier to access network resources and services.
2. **Enhanced Connectivity**: Bridged networking allows for seamless communication between your WSL2 instance and other devices on the network, improving overall connectivity.
3. **Static IP Configuration**: The script allows you to assign a static IP address to your WSL2 instance, ensuring consistent network configuration across reboots.
4. **Automated Setup**: The provided script automates the process of setting up bridged networking, saving you time and effort.

## Benefits for Hackers and Penetration Testers

1. **Direct Network Access**: Bridged networking provides your WSL2 instance with direct access to the network, allowing you to perform more realistic penetration tests. This setup mimics the behavior of an insider threat, enabling you to test internal security measures effectively.
2. **Unrestricted Exploit Traffic**: With bridged networking, exploit traffic can flow freely between your WSL2 instance and target machines without being blocked or altered by the host's firewall or antivirus software. This ensures that your penetration tests are accurate and effective.
3. **Improved Network Visibility**: Bridged networking enhances network visibility, allowing you to use tools like `nmap` to scan the network for vulnerabilities more effectively. You can also capture and analyze network traffic directly from the network, providing deeper insights into potential security issues.
4. **Access to Broadcast Traffic**: Bridged networking enables your WSL2 instance to access broadcast traffic on the network, which can be useful for discovering devices and services that are not directly reachable. This can help identify additional attack vectors and potential targets.
5. **Consistent Testing Environment**: By assigning a static IP address to your WSL2 instance, you ensure that your network configuration remains consistent across reboots. This stability is crucial for maintaining a reliable testing environment and for automating penetration testing tasks.

## Usage

1. **Save the Script**: Save the provided PowerShell script as `SetupWSLBridgedNetwork.ps1`.
2. **Run the Script with Administrative Privileges**:

   - Open PowerShell as an administrator.
   - Navigate to the directory where the script is saved.
   - Execute the script using the command:
     ```powershell
     .\SetupWSLBridgedNetwork.ps1
     ```
3. **Automate the Script Execution on Startup**:

   - Use Task Scheduler to run the script at startup, ensuring that the network configuration persists across reboots.

### **Steps to Automate Script Execution on Startup**

1. **Open Task Scheduler**:

   - Press `Win + R`, type `taskschd.msc`, and press Enter.
2. **Create a New Task**:

   - Click on "Create Task" in the right-hand Actions pane.
   - Name the task (e.g., "WSL Bridged Network Setup").
   - Under the "General" tab, select "Run with highest privileges".
3. **Set the Trigger**:

   - Go to the "Triggers" tab and click "New".
   - Set the trigger to "At startup".
4. **Set the Action**:

   - Go to the "Actions" tab and click "New".
   - Set the action to "Start a program".
   - In the "Program/script" field, enter `powershell.exe`.
   - In the "Add arguments (optional)" field, enter the path to your script:
     ```plaintext
     -File "C:\Path\To\SetupWSLBridgedNetwork.ps1"
     ```
5. **Finish and Save**:

   - Click "OK" to save the task.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
