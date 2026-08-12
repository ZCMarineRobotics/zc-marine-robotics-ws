# 🤖 RoboSubZC ROS 2 Development Environment

This environment provides a fully sandboxed Ubuntu system with ROS 2 Lyrical pre-installed, customized terminal tools, and seamless file sharing with your host computer.

---

## 📋 Prerequisites

Before you start, make sure your system has the following installed:

1. **Git:** To clone this repository.
2. **Docker:** The core container engine.
   - **Windows/Mac:** Install [Docker Desktop](https://www.docker.com/products/docker-desktop/). (Windows users must ensure the WSL2 backend is enabled).
   - **Linux:** Install Docker Engine and the Docker Compose plugin via your package manager.
3. **An X11 Server (For GUI Apps like RViz):**
   - **Linux:** Built-in. You just need the `xhost` utility.
   - **Windows:** Built into WSL2 (WSLg). No extra setup required!
   - **macOS:** You will need to install and run [XQuartz](https://www.xquartz.org/).

---

## 🚀 How to Launch the Environment

We support two different workflows depending on your editor preference.

### Method A: VS Code Dev Containers (Highly Recommended)

This is the recommended workflow. It injects the VS Code server directly into the container, giving you flawless C++ and Python autocomplete for ROS 2 without needing to install anything locally.

1. Open this repository folder in VS Code.
2. Install the official Microsoft extension: **Dev Containers** (`ms-vscode-remote.remote-containers`).
3. A pop-up will appear in the bottom right corner asking to **Reopen in Container**. Click it! _(Alternatively, press `Ctrl+Shift+P`, type "Dev Containers: Reopen in Container", and press Enter)._
4. Wait for the container to build (this takes a few minutes the first time).
5. Open a new terminal in VS Code (`Ctrl + ~`) — you are now inside the ROS 2 environment!

### Method B: The Command Line (For Neovim/CLion/Other IDEs)

If you prefer a terminal-based editor like Neovim, or want to use a different IDE on your host computer, you can run the container directly from your terminal.

**1. Start the Container in the Background:**
Open your terminal in this repository's folder and run:

```bash
docker compose up -d
```

**2. Open a Terminal inside the Container:**
To drop into the custom Zsh shell, run:

```bash
docker compose exec robosubzc zsh
```

_(Need multiple terminal tabs? Just open a new tab on your host computer and run that `exec` command again!)_

**3. Stop the Container:**
When you are done working for the day, clean up by running:

```bash
docker compose down
```

---

## 🏗️ Workspace Structure & ROS 2 Aliases

For ROS 2 to build correctly, all of our packages must live inside the `src/` directory. **Do not put ROS 2 packages in the root of the repository.**

To make development faster, this environment comes pre-loaded with custom terminal shortcuts. You can use these from anywhere inside the container:

| Alias       | Full Command                                             | What it does                                        |
| :---------- | :------------------------------------------------------- | :-------------------------------------------------- |
| `cb`        | `colcon build --symlink-install`                         | Compiles the entire workspace.                      |
| `cbp <pkg>` | `colcon build --symlink-install --packages-select <pkg>` | Compiles only a specific package (much faster).     |
| `rdi`       | `rosdep install --from-paths src --ignore-src -y`        | Installs any missing dependencies for our packages. |
| `rt`        | `ros2 topic list`                                        | Lists all active ROS 2 topics.                      |
| `rn`        | `ros2 node list`                                         | Lists all active ROS 2 nodes.                       |

_Note: Because we build with `--symlink-install`, any changes you make to a Python file will take effect instantly. You only need to rebuild (`cb` / `cbp`) when you change C++ code or package configurations!_

---

## 🪞 How File Sharing Works

We use a Docker feature called **Volume Mapping**. The folder you cloned on your laptop is directly linked to the `/home/dev/RoboSubZC` folder inside the container.

- Any file you create inside the container is instantly saved to your laptop's hard drive.
- Any file you edit on your laptop is instantly seen by the container.
- If you delete the container entirely, your source code remains 100% safe on your computer.

---

## ✨ Quality of Life: Automate Linux GUI Permissions

_(Note: This section is for native Linux users only)._

By default, Linux blocks containers from opening graphical windows like RViz2 for security. Instead of typing `xhost +local:root` every time you restart your computer, you can automate it!

Add this single line to your host laptop's shell configuration file (`~/.bashrc` or `~/.zshrc`):

```bash
# Automatically allow local Docker containers to display GUI apps
xhost +local:root > /dev/null 2>&1
```

Save the file and run `source ~/.bashrc` (or `.zshrc`). Now your GUI permissions will unlock automatically every time you open a terminal!

---

## 🚑 Common Troubleshooting

### 1. RViz2 or GUI apps won't open

**Error:** `could not connect to display` or `qt.qpa.xcb: could not connect to display`

- **Linux Fix:** Your X11 server blocked the container. Run `xhost +local:root` on your host computer.
- **Mac Fix:** Ensure XQuartz is running, run `xhost +` in your Mac terminal, and ensure your `DISPLAY` variable is configured for Docker Mac forwarding.

### 2. I have a bunch of red squiggly error lines in VS Code

**Fix:** You opened the folder locally instead of inside the Dev Container. Make sure you install the "Dev Containers" extension and click "Reopen in Container". Your host laptop does not have ROS 2 installed, so it cannot find the libraries.

### 3. Build fails with a network or "NOSPLIT" error

**Error:** `Clearsigned file isn't valid, got 'NOSPLIT'`
**Fix:** This happens when an ISP intercepts HTTP traffic. Our Dockerfile forces HTTPS, but if it still fails, simply rerun the build command. It is usually a temporary network hiccup.
