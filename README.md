# Laptop Lid Action Changer

This PowerShell script allows you to easily change the action your laptop performs when the lid is closed. You can choose between Sleep, Shut Down, or Do Nothing for both battery and plugged-in power modes.
feel free to update code and send pull request

## Features

- Select between three actions when closing your laptop's lid:
  - Sleep
  - Shut Down
  - Do Nothing
- Applies the chosen action for both plugged-in (AC) and battery (DC) power modes.
- Automatically runs with administrator privileges if required.

## How It Works

When you run the script, you'll be prompted to choose the desired action for closing your laptop's lid. The script then retrieves your active power plan GUID and applies the selected action for both AC and DC power modes. The changes are applied immediately.

## Usage

1. **Clone or Download the Script**
   - Clone this repository or download the script (`lid.ps1`) to your local machine.

2. **Open PowerShell as Administrator**
   - The script requires administrator privileges to change system power settings. Make sure you open PowerShell as an Administrator.

3. **Run the Script**
   - Navigate to the directory where the script is located, then run the following command:
     ```powershell
     .\lid.ps1
     ```
   - You'll be prompted to select one of the actions for when you close your laptop's lid.

4. **Select an Action**
   - After making a selection, the script will apply the new settings for both plugged-in and battery modes.

## Example Output

```powershell
Select laptop lid action:
1 - Sleep
2 - Shut down
3 - Do nothing
Enter your choice (1/2/3): 1
You selected: Sleep
Lid close action has been updated to Sleep.
