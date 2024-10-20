FROM ubuntu:latest


RUN apt-get update && \
    apt-get install -yq software-properties-common && \
    apt-add-repository ppa:fish-shell/release-3 && \
    apt-get update && \
    apt-get install -yq fish neovim curl git htop bat tar tmux tzdata unzip ripgrep make fzf gcc

RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

ARG LAZYGIT_VERSION=0.44.1
RUN curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
RUN tar xf lazygit.tar.gz lazygit
RUN install lazygit /usr/local/bin

RUN apt-get install -yq fontconfig

RUN curl -Lo cc.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip
RUN unzip cc.zip -d /root/.fonts/
RUN fc-cache -fv

COPY config/ /root/.config/


# installs nvm (Node Version Manager)
ENV NODE_VERSION=20.18.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
RUN echo "set -gx PATH \$PATH /root/.nvm/versions/node/v${NODE_VERSION}/bin/" >> /root/.config/fish/config.fish

RUN git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm && ~/.config/tmux/plugins/tpm/bin/install_plugins

RUN chsh -s /usr/bin/fish
