# 🤖 ZCMarineRobotics ROS 2 Development Environment

This environment provides a fully sandboxed Ubuntu system with ROS 2 Lyrical pre-installed, customized terminal tools, and seamless file sharing with your host computer.

---

## 📋 Prerequisites & Local Setup Steps

Follow these steps directly from your Windows terminal and your WSL Ubuntu environment to set up everything from scratch:

1. **Install WSL2 & Ubuntu:** 
   Open your Windows PowerShell or Command Prompt as Administrator and install WSL along with Ubuntu:
   ```cmd
   wsl --install Ubuntu
   ```
   Reboot your computer if prompted, then open your newly installed **Ubuntu** terminal to complete the user account setup.

2. **Install Docker Engine inside Ubuntu:** Run the following commands sequentially in your Ubuntu terminal:
   ```bash
   sudo apt update && sudo apt install curl -y
   curl -fsSL https://get.docker.com | sh
   ```

3. **Configure Docker Permissions:** Add your current user to the Docker group so you can run commands without `sudo`:
   ```bash
   sudo usermod -aG docker $USER
   ```
   *(Note: Close and reopen your WSL terminal after running this command for it to take effect).*

4. **Enable Systemd for Docker:** Configure systemd locally inside your distro so Docker starts automatically. Open `/etc/wsl.conf`:
   ```bash
   sudo nano /etc/wsl.conf
   ```
   Add the following lines, save, and exit:
   ```ini
   [boot]
   systemd=true
   ```
   Then, shut down WSL from your terminal (`wsl.exe --shutdown`), reopen your Ubuntu terminal, and enable the Docker service:
   ```bash
   sudo systemctl enable --now docker
   ```

5. **Clone the Repository:** Pull your project repository into your WSL file system:
   ```bash
   cd ~
   git clone https://github.com/ZCMarineRobotics/zc-marine-robotics-ws.git && cd zc-marine-robotics-ws
   ```

6. **Open in VS Code & Launch Dev Container:** 
   Open the project folder inside VS Code by typing:
   ```bash
   code .
   ```
   Inside VS Code, install the **Dev Containers** extension (`ms-vscode-remote.remote-containers`), press `Ctrl+Shift+P`, select **"Dev Containers: Reopen in Container"**, and choose your target environment configuration.

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

We use a Docker feature called **Volume Mapping**. The folder you cloned on your WSL distribution is directly linked to the workspace folder inside the container.

- Any file you create inside the container is instantly saved to your Linux file system.
- Any file you edit in VS Code is instantly seen by the container.
- If you delete the container entirely, your source code remains 100% safe on your computer.

---

## 🚑 Common Troubleshooting

### 1. RViz2 or GUI apps won't open
**Error:** `could not connect to display` or `qt.qpa.xcb: could not connect to display`
- **WSL Fix:** Ensure you are using a modern Windows version with WSLg enabled, which handles GUI forwarding automatically out of the box.

### 2. I have a bunch of red squiggly error lines in VS Code
**Fix:** You opened the folder locally instead of inside the Dev Container. Make sure you install the "Dev Containers" extension and click "Reopen in Container". Your host environment does not have ROS 2 installed locally, so it cannot find the libraries unless running inside the container.

### 3. Build fails with a network or "NOSPLIT" error
**Error:** `Clearsigned file isn't valid, got 'NOSPLIT'`
**Fix:** This happens when an ISP intercepts HTTP traffic. Our Dockerfile forces HTTPS, but if it still fails, simply rerun the build command. It is usually a temporary network hiccup.
