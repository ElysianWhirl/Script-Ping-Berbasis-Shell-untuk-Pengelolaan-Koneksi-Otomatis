# Ping Monitoring and Automated Airplane Mode Script

This script monitors the connectivity of specified hosts using ping. If all hosts fail to respond consecutively for a specified number of attempts, it automatically activates airplane mode on the connected Android device using ADB (Android Debug Bridge). After a defined downtime period, it restores normal connectivity by deactivating airplane mode.

## Features

- **Ping Monitoring:** Continuously pings multiple hosts to check connectivity status.
- **Automated Airplane Mode:** Activates airplane mode if all specified hosts fail to respond.
- **Configurability:** Adjustable parameters for ping retries and downtime duration.
- **Integration with ADB:** Uses ADB commands to interact with Android device settings.

## Usage

1. **Setup:**
   - Ensure ADB (Android Debug Bridge) is installed and configured to communicate with your Android device.
   - Modify the script to include the addresses of hosts you want to monitor (`HOST1`, `HOST2`, etc.).

2. **Execution:**
   - Run the script in a shell environment that supports `ash` (Almquist shell).

3. **Monitoring:**
   - Watch the script's console output to monitor connectivity status and automated actions.

## Requirements

- ADB (Android Debug Bridge) configured and accessible from the shell environment.
- Shell environment compatible with `ash` shell scripting.
- Suitable permissions to execute ADB commands on the connected Android device.

## Example

```bash
$ ./ping_monitor.sh
