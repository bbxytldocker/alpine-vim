# FROM alpine:latest
FROM frolvlad/alpine-glibc

MAINTAINER bbxytl <bbxytl@gmail.com>

RUN apk add --no-cache --update --virtual \
    build-deps \
    build-base \
    ctags \
    git \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    make \
    ncurses-dev \
    python \
    python-dev \
    bash \
# Build Vim
    && cd /tmp \
    && git clone https://github.com/vim/vim \
    && cd /tmp/vim \
    && ./configure \
    --disable-gui \
    --disable-netbeans \
    --enable-multibyte \
    --enable-pythoninterp \
    --prefix=/usr \
    --with-features=big \
    --with-python-config-dir=/usr/lib/python2.7/config \
    && make install \
    && apk del build-deps \
    && apk add \
    libice \
    libsm \
    libx11 \
    libxt \
    ncurses \
    curl \
    git  \
    bash \
    zsh  \

# Cleanup
    && rm -rf \
    /tmp/*  \
    /var/cache/* \
    /var/log/* \
    /var/tmp/* \
    && mkdir /var/cache/apk

# User config
ENV UID="1000" \
    UNAME="developer" \
    GID="1000" \
    GNAME="developer" \
    SHELL="/bin/bash" \
    UHOME="/home/developer" \
    UVIMHOME="/home/developer/.vim" \
    UDOTFILES="/home/developer/mydotfiles/b-dotfiles"

# User
RUN apk --no-cache add sudo \
# Create HOME dir
    && mkdir -p "${UHOME}" \
    && chown "${UID}":"${GID}" "${UHOME}" \
# Create user
    && echo "${UNAME}:x:${UID}:${GID}:${UNAME},,,:${UHOME}:${SHELL}" \
    >> /etc/passwd \
    && echo "${UNAME}::17032:0:99999:7:::" \
    >> /etc/shadow \
# No password sudo
    && echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" \
    > "/etc/sudoers.d/${UNAME}" \
    && chmod 0440 "/etc/sudoers.d/${UNAME}" \
# Create group
    && echo "${GNAME}:x:${GID}:${UNAME}" \
    >> /etc/group

USER $UNAME
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Vim plugins deps
RUN mkdir -p \
    $UVIMHOME/bundle \
    $UVIMHOME/vimbackup \
    $UVIMHOME/vimswap \
    $UVIMHOME/vimundo \
    $UVIMHOME/runtime \
    && cd $UVIMHOME/bundle/ \
    && git clone https://github.com/gmarik/vundle.git $UVIMHOME/bundle/vundle \
    && git clone --depth 1 https://github.com/tomasr/molokai  \
    && git clone --depth 1 https://github.com/asins/vimcdoc  \
    && git clone --depth 1 https://github.com/airblade/vim-rooter  \
    && git clone --depth 1 https://github.com/nathanaelkane/vim-indent-guides  \
    && git clone --depth 1 https://github.com/scrooloose/syntastic  \
    && git clone --depth 1 https://github.com/vim-scripts/OmniCppComplete  \
    && git clone --depth 1 https://github.com/vim-scripts/Pydiction  \
    && git clone --depth 1 https://github.com/yssource/python.vim  \
    && git clone --depth 1 https://github.com/Raimondi/delimitMate  \
    && git clone --depth 1 https://github.com/scrooloose/nerdcommenter  \
    && git clone --depth 1 https://github.com/bronson/vim-trailing-whitespace  \
    && git clone --depth 1 https://github.com/Lokaltog/vim-easymotion  \
    && git clone --depth 1 https://github.com/vim-scripts/matchit.zip  \
    && git clone --depth 1 https://github.com/kshenoy/vim-signature  \
    && git clone --depth 1 https://github.com/terryma/vim-expand-region  \
    && git clone --depth 1 https://github.com/terryma/vim-multiple-cursors  \
    && git clone --depth 1 https://github.com/ctrlpvim/ctrlp.vim  \
    && git clone --depth 1 https://github.com/kien/rainbow_parentheses.vim  \
    && git clone --depth 1 https://github.com/scrooloose/nerdtree  \
    && git clone --depth 1 https://github.com/jistr/vim-nerdtree-tabs  \
    && git clone --depth 1 https://github.com/majutsushi/tagbar  \
    && git clone --depth 1 https://github.com/kevinw/pyflakes-vim  \
    && git clone --depth 1 https://github.com/hdima/python-syntax  \
    && git clone --depth 1 https://github.com/plasticboy/vim-markdown  \
    && git clone --depth 1 https://github.com/Mizuchi/STL-Syntax  \
    && git clone --depth 1 https://github.com/vim-scripts/a.vim  \
    && git clone --depth 1 https://github.com/vim-scripts/AutoComplPop  \
    && git clone --depth 1 https://github.com/vim-airline/vim-airline  \
    && git clone --depth 1 https://github.com/vim-airline/vim-airline-themes  \
    && git clone --depth 1 https://github.com/rking/ag.vim  \
    && git clone --depth 1 https://github.com/airblade/vim-gitgutter  \
    && git clone --depth 1 https://github.com/sjl/gundo.vim

# install config
RUN mkdir -p $UHOME/mydotfiles \
    && cd $UHOME/mydotfiles \
    && git clone --depth 1 https://github.com/bbxytl/b-dotfiles \
    && cd $UDOTFILES/b-vim/vim.config  \
    && sh install-vim-for-docker.sh  \
    && cd $UDOTFILES/b-shell  \
    && sh install-shell-for-docker.sh  \
    && cd $UDOTFILES/others  \
    && sh install-others-for-docker.sh


ENV TERM=xterm-256color

# ENV DISABLE=""

ENTRYPOINT ["zsh"]
