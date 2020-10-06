FROM ubuntu:20.04

RUN apt-get update \
 && apt-get -y install curl git nano gawk

ENV X_USER "entando"

RUN adduser --disabled-password --gecos '' $X_USER \
 && mkdir "/WORKDIR" \
 ;
 
ADD files/jhipster-wrapper.sh /home/$X_USER/jhipster-wrapper.sh

RUN chown $X_USER:$X_USER "/home/$X_USER" \
 && chown $X_USER:$X_USER "/WORKDIR";

USER $X_USER

ENV ENTANDO_VERSION   "v6.2.1-sprint10"
ENV ENT_VERSION       "v6.2.1-sprint10"
ENV DUMMY             1

RUN bash -c 'cd "$HOME";\
    export ENT_VERSION;\
    export ENTANDO_VERSION;\
    curl "https://raw.githubusercontent.com/entando/entando-cli/$ENT_VERSION/auto-install" | bash;\
    cd "$HOME";\
    echo "" >> .bashrc;\
    echo "# ~~~" >> .bashrc;\
    ln -s /home/entando/.entando/ent/$ENTANDO_VERSION/cli/$ENT_VERSION/activate entando-activate;\
    echo ". /home/entando/.entando/ent/$ENTANDO_VERSION/cli/$ENT_VERSION/activate" >> .bashrc;\
    . /home/entando/.entando/ent/$ENTANDO_VERSION/cli/$ENT_VERSION/activate;\
    cd "$HOME";\
    yes | ent-check-env.sh --lenient develop;\
    cd "$HOME";\
    ls -la;\
    echo COMPLETED;'\
 ;
