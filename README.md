# 🤖 RoboSub ROS 2 Development Environment

Welcome to the RoboSub software repository! We use a containerized Docker environment to ensure everyone on the team has the exact same setup. 

---

## 📋 Prerequisites

Before you start, make sure your system has the following installed:
1. **Docker:** The core container engine.
2. **Docker Compose:** The plugin that manages our container settings.
3. **xhost:** A utility to allow the container to securely stream GUI applications (like RViz2) to your screen.

*(If you are on Arch Linux, you may need to install the compose plugin explicitly: `sudo pacman -S docker-compose`)*

---

## 🚀 Quick Start

Open your terminal in this directory and run these commands to start coding.

### 1. Build the Image (First time only)
Compile the container image and download our dependencies. This takes a few minutes the first time, but will be nearly instant afterward.
```bash
docker compose build
```

### 2. Launch the Environment
Boot the container and drop into your terminal. 
```bash
docker compose run --rm robosub
```
*Note: The environment will automatically detect if your host computer uses `zsh` or `bash` and launch the exact same shell inside the container!*

---

## ✨ Quality of Life: Automate GUI Permissions (`xhost`)

By default, Linux blocks containers from opening graphical windows like RViz2 for security. Instead of typing `xhost +local:root` every time you restart your computer, you can automate it!

Add this single line to your host shell's configuration file (`~/.bashrc` or `~/.zshrc`):

```bash
# Automatically allow local Docker containers to display GUI apps
xhost +local:root > /dev/null 2>&1
```

Save the file and run `source ~/.bashrc` (or `source ~/.zshrc`). Now your GUI permissions will unlock automatically every time you open a terminal!

---

## 🛠️ How it Works

When you run the launch command, you are dropped into a sandboxed Ubuntu environment running ROS 2 Lyrical, but **your code is shared**.

* **Live Editing:** The `RoboSub` folder on your computer is mapped directly into the container at `/root/RoboSub`. If you edit a Python or C++ file using VS Code on your host computer, the container sees the change instantly.

---

## 🚑 Common Troubleshooting

### 1. RViz2 or GUI apps won't open
**Error:** `could not connect to display` or `qt.qpa.xcb: could not connect to display`

**Fix:** Your X11 server blocked the container. If you didn't set up the automation snippet above, open a terminal on your **host computer** (not inside Docker) and run:
```bash
xhost +local:root
```

### 2. Docker Compose command not found
**Error:** `docker: unknown command: docker compose`

**Fix:** You only have the core Docker engine installed. Install the compose plugin via your package manager (e.g., `sudo apt install docker-compose-plugin` on Ubuntu or `sudo pacman -S docker-compose` on Arch).

### 3. "Permission Denied" when editing files
**Error:** You try to edit a file on your host computer, but it says it is locked or owned by `root`.

**Fix:** Because the container runs as the `root` user, any *new* files you generate inside the container (like running `colcon build`) belong to root. To fix this on your host computer, run:
```bash
sudo chown -R $USER:$USER .
```

### 4. Build fails with a network or "NOSPLIT" error
**Error:** `Clearsigned file isn't valid, got 'NOSPLIT'`

**Fix:** This happens when an ISP intercepts HTTP traffic. Our `Dockerfile` forces HTTPS, but if it still fails, simply rerun `docker compose build`. It is usually a temporary network hiccup.