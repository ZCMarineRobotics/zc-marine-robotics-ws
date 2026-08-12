FROM osrf/ros:lyrical-desktop

ARG USER_ID
ARG GROUP_ID
ARG USER_NAME=dev

ENV HOME=/home/${USER_NAME}

RUN sed -i 's/http:/https:/g' /etc/apt/sources.list.d/*

RUN apt-get update && apt-get install -y \
    zsh \
    git \
    curl \
    neovim \
    tmux \
    fzf \
    ripgrep \
    fd-find \
    bat \
    eza \
    zoxide \
    tealdeer \
    shared-mime-info \
    qt6-svg-plugins \
    && rm -rf /var/lib/apt/lists/*

# Create the user dynamically using your host IDs
RUN if getent group ${GROUP_ID}; then \
    group_name=$(getent group ${GROUP_ID} | cut -d: -f1); \
    groupadd -g 9999 temp_grp 2>/dev/null || true; \
    else \
    group_name="${USER_NAME}"; \
    groupadd -g ${GROUP_ID} ${group_name}; \
    fi && \
    if getent passwd ${USER_ID}; then \
    existing_user=$(getent passwd ${USER_ID} | cut -d: -f1); \
    usermod -l ${USER_NAME} -d ${HOME} -m ${existing_user} || true; \
    else \
    useradd -l -u ${USER_ID} -g ${group_name} -m -s /bin/zsh ${USER_NAME}; \
    fi && \
    usermod -aG sudo ${USER_NAME} && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

USER ${USER_NAME}
WORKDIR ${HOME}

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

RUN mkdir -p $HOME/.config

COPY --chown=${USER_NAME}:${USER_NAME} .config/.zshrc $HOME/.zshrc
COPY --chown=${USER_NAME}:${USER_NAME} .config/.bashrc $HOME/.bashrc
COPY --chown=${USER_NAME}:${USER_NAME} .config/starship.toml $HOME/.config/starship.toml

RUN sudo rosdep init || true
RUN rosdep update

CMD ["bash", "-c", "echo -e '\\n\\e[1;36mWelcome to the RoboSubZC Environment!\\e[0m\\n'; if [[ \"$HOST_SHELL\" == *zsh* ]]; then exec zsh; else exec bash; fi"]