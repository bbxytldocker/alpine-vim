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

# install complex vim config
RUN cd $UDOTFILES/b-vim/vim.config  \
	&& sh install-vim-for-docker.sh  --complex \
	&& cd $UVIMHOME/bundle/ \
	&& git clone --depth 1 https://github.com/SirVer/ultisnips  \
	&& git clone --depth 1 https://github.com/honza/vim-snippets  \
	&& git clone --depth 1 https://github.com/tpope/vim-surround  \
	&& git clone --depth 1 https://github.com/tpope/vim-repeat  \
	&& git clone --depth 1 https://github.com/tacahiroy/ctrlp-funky  \
	&& git clone --depth 1 https://github.com/dyng/ctrlsf.vim  \
	&& git clone --depth 1 https://github.com/szw/vim-ctrlspace  \
	&& git clone --depth 1 https://github.com/tdcdev/ycm_simple_conf  \
	&& git clone --depth 1 https://github.com/Valloric/ListToggle  \
	&& git clone --depth 1 https://github.com/junegunn/vim-easy-align  \
	&& git clone --depth 1 https://github.com/thinca/vim-quickrun  \
	&& git clone --depth 1 https://github.com/uguu-org/vim-matrix-screensaver  \
	&& git clone --depth 1 https://github.com/vim-scripts/TagHighlight  \
	&& git clone --depth 1 https://github.com/ochaloup/vim-syntax-match  \
	&& git clone --depth 1 https://github.com/vim-scripts/DoxygenToolkit.vim  \
	&& git clone --depth 1 https://github.com/Valloric/YouCompleteMe  \
	&& cd $UVIMHOME/bundle/YouCompleteMe \
	&& git submodule update --init --recursive

### 简单编译处理, 只支持 c 系列, 不能继续扩展
#RUN sudo apk --update add  \
#		# boost \
#		llvm \
#		libclang-dev  \
#		python \
#	&& sudo apk add --virtual build-deps \
#		gcc  \
#		g++  \
#		make \
#		cmake \
#		python-dev \
#	&& cd $UVIMHOME/bundle/YouCompleteMe \
#	# && python ./install.py --clang-completer --system-libclang --system-boost  \
#	&& python ./install.py --clang-completer --system-libclang \
## Cleanup
#	&& sudo apk del build-deps \
#		cmake  \
#	&& sudo rm -rf \
#	/tmp/*  \
#	/var/cache/* \
#	/var/log/* \
#	/var/tmp/* \
#	&& sudo mkdir /var/cache/apk

#### 可扩展性编译
#USER root
#RUN apk --update add \
#	ncurses-terminfo \
#	python \
#	&& apk add --virtual build-deps \
#		build-base \
#		make \
#		cmake \
#		llvm \
#		perl \
#		python-dev \
#		xz  \
#		tar \
#	# && mkdir -p $UVIMHOME/bundle/YouCompleteMe/third_party/ycmd/clang_archives  \
#	# && cd $UVIMHOME/bundle/YouCompleteMe/third_party/ycmd/clang_archives/ \
#	&& mkdir -p /tmp/ycm_temp  \
#		/tmp/ycm_temp/build  \
#	&& cd /tmp/ycm_temp/  \
#	&& curl -o clang+llvm-4.0.1-x86_64-linux-gnu-debian8.tar.xz http://releases-origin.llvm.org/4.0.1/clang+llvm-4.0.1-x86_64-linux-gnu-debian8.tar.xz \
#	&& xz -d  clang+llvm-4.0.1-x86_64-linux-gnu-debian8.tar.xz \
#	&& tar -xvf   clang+llvm-4.0.1-x86_64-linux-gnu-debian8.tar.xz \
#	&& cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=/tmp/ycm_temp/clang+llvm-4.0.1-x86_64-linux-gnu-debian8 . $UVIMHOME/bundle/YouCompleteMe/third_party/ycmd/cpp
## Cleanup
#	&& apk del build-deps \
#		cmake  \
#		llvm  \
#		xz  \
#		tar  \
#	&& rm -rf \
#	/tmp/*  \
#	/var/cache/* \
#	/var/log/* \
#	/var/tmp/* \
#	&& mkdir /var/cache/apk


### 可扩展性编译
USER root
RUN apk --update add \
	ncurses-terminfo \
	python \
	&& apk add --virtual build-deps \
		build-base \
		make \
		cmake \
		llvm \
		perl \
		python-dev \
		xz  \
		tar \
	&& mkdir -p /tmp/ycm_temp  \
		/tmp/ycm_temp/build  \
	&& cd /tmp/ycm_temp/  \
	&& curl -o clang+llvm-4.0.1-x86_64-linux-gnu-debian8.tar.xz http://releases-origin.llvm.org/4.0.1/clang+llvm-4.0.1-x86_64-linux-gnu-debian8.tar.xz \
	&& xz -d  clang+llvm-4.0.1-x86_64-linux-gnu-debian8.tar.xz \
	&& tar -xf   clang+llvm-4.0.1-x86_64-linux-gnu-debian8.tar \
	&& mv clang+llvm-4.0.1-x86_64-linux-gnu-debian8 clang_llvm_dir  \
	# && mkdir -p $UVIMHOME/bundle/YouCompleteMe/third_party/ycmd/clang_archives  \
	# && cd $UVIMHOME/bundle/YouCompleteMe/third_party/ycmd/clang_archives/ \
	&& cd /tmp/ycm_temp/build  \
	&& cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=/tmp/ycm_temp/clang_llvm_dir . $UVIMHOME/bundle/YouCompleteMe/third_party/ycmd/cpp  \
	&& cmake --build . --target ycm_core --config Release  \
# Cleanup
	&& apk del build-deps \
	&& rm -rf \
	/tmp/*  \
	/var/cache/* \
	/var/log/* \
	/var/tmp/* \
	&& mkdir /var/cache/apk


USER $UNAME

ENV TERM=xterm-256color

# ENV DISABLE=""

ENTRYPOINT ["zsh"]
