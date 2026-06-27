
# Conf

This repository is my **personal config store** where I keep everything I generally use, so I can maintain versions and easily manage my setup.

I also keep a lot of **automation scripts, tools, and config files** here that I use on my laptop.

Feel free to use anything here according to your needs. Everything is **free to use**, and you can **customize it** as you like.

If you want, you can **star this repo** ❤️ - I regularly update it with my settings, configs, scripts, and automation tools.
This helps me in daily life, and I hope it will help you too!

---

## Usage

Clone the repository and explore the files:

```bash
git clone https://github.com/rishiyaduwanshi/conf.git
```

Use, modify, or add new scripts and configs as you want - **do whatever you like according to your needs**.

You can also download and use scripts through **Boiler**.
If you are not familiar with Boiler, visit **https://boiler.iamabhinav.dev** to learn more.

### Download with Boiler

You can directly download and add the full stack:

```bash
bl add github.com:rishiyaduwanshi/conf . -rk
```

If you only want one particular script, you can download that too:

```bash
bl add github.com:rishiyaduwanshi/conf/scripts/createFile.ahk . -rn
```

---

## 🛠️ Available Scripts & Features

This repository includes several scripts that boost productivity and automate daily tasks. Here is a breakdown of what they do and how to use them:


### 1. `terminal.ahk` (Quick Terminal & IDE Opener)
Quickly open a terminal or a specific IDE in the folder you currently have open in Windows File Explorer.
- **Shortcut:** `Alt + T` - Opens **PowerShell** in the current Explorer directory (or Desktop).
- **Shortcut:** `Alt + E` - Opens a **GUI** to let you choose an IDE to open the current folder in. 
  - Supported IDEs include: VS Code (V), Cursor (C), Trae (T), Android Studio (A), IntelliJ IDEA (I), and Antigravity (G). 
  - You can also use "Blank Mode" (B) to just open the IDE without a specific folder.

### 2. `createFile.ahk` (Quick File Creator)
Create files instantly in your current Windows File Explorer directory without right-clicking.
- **Shortcut:** `Ctrl + Shift + F`
- **Usage:** Opens an input box where you can type the filename (e.g., `script.js`).
- **Bonus:** Add `-e` at the end (e.g., `script.js -e`) to create the file and instantly open it in VS Code. You can also specify an editor like `index.html -e notepad`.


### 3. `setupGithub.ps1` (Quick GitHub Repo Setup)
A PowerShell script to quickly initialize a local Git repository and create a remote repository on GitHub using the GitHub CLI.
- **Usage:** Run `.\setupGithub.ps1` in PowerShell. It will prompt you for the repository name and whether it should be private or public.
- **Local Only:** You can run it with the `-LocalOnly` flag (e.g., `.\setupGithub.ps1 -LocalOnly`) to just initialize the local repo and skip creating the GitHub remote.
- **Prerequisites:** Requires Git and the GitHub CLI (`gh`) to be installed and authenticated.

### 4. `Keyboard.ahk` (PowerPoint Presentation Helper)
Enhances PowerPoint presentations by allowing you to quickly change pen colors using your keyboard.
- **Usage:** While a PowerPoint slideshow is active, press letter keys (e.g., `a` for Aqua, `b` for Black, `r` for Red, `w` for White, etc.) to instantly change the drawing pen color.

---