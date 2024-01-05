FROM kasmweb/core-debian-bullseye:1.14.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

# ROOT ACCESS #
RUN apt update \
    && apt install -y sudo nano \
    && echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && rm -rf /var/lib/apt/list/*
# End ROOT ACCESS #


######### Customize Container Here ###########
RUN apt install -y git cmake build-essential libqpdf-dev libmagick++-dev qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5svg5-dev qttools5-dev graphicsmagick && rm -rf /var/lib/apt/lists/*
RUN git clone https://gitlab.com/scarpetta/pdfmixtool ##&& cd pdfmixtool && mkdir build && cd build && make -j 6 && make install


RUN cd pdfmixtool && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release && \
    make -j 6 && \
    make install 

RUN echo "/usr/bin/desktop_ready && /usr/bin/pdfmixtool" > $STARTUPDIR/custom_startup.sh \
&& chmod +x $STARTUPDIR/custom_startup.sh


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
