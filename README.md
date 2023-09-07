# Book My Show Bot Creator

This project is used to create Indian Personas and Initialize n (n < 50) Browsers with certain configurations to run bots or extensions scripts.

## How to Spin up Browsers

1. Click on init-browsers-<operating_system> , for your particular Operating System.
2. If on windows use **powershell** to run the <code>main.ps1</code> file. If on Linux use **bash** to run the <code>main.sh</code> file.
3. A Google Chrome Browser will open up, set up your configuration for the browser here, ideally you should install a custom extension. After you are done with your configuration, close the browser and wait.
4. After some time, the console will ask you how many windows you would like to open, enter any value between 1 and 50 (Make sure it is not above 50) and press Enter.
5. Now the console will ask you to provide a list of websites to open, enter the list of websites to open , seperated by a space bar.
6. Press Enter.
7. The script will spin up the n independant browser windows.
