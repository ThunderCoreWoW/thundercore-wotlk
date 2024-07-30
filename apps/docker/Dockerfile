ARG UBUNTU_VERSION=22.04 # lts
ARG TZ=Etc/UTC

# This target lays out the general directory skeleton for ThunderCore,
# This target isn't intended to be directly used
FROM ubuntu:$UBUNTU_VERSION as skeleton

ARG DOCKER=1
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=$TZ
ENV TC_FORCE_CREATE_DB=1

RUN mkdir -pv \
        /thundercore/bin                   \
        /thundercore/data                  \
        /thundercore/deps                  \
        /thundercore/env/dist/bin          \
        /thundercore/env/dist/data/Cameras \
        /thundercore/env/dist/data/dbc     \
        /thundercore/env/dist/data/maps    \
        /thundercore/env/dist/data/mmaps   \
        /thundercore/env/dist/data/vmaps   \
        /thundercore/env/dist/logs         \
        /thundercore/env/dist/temp         \
        /thundercore/env/dist/etc          \
        /thundercore/modules               \
        /thundercore/src                   \
        /thundercore/build

# Configure Timezone
RUN apt-get update                                          \
    && apt-get install -y tzdata ca-certificates            \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime   \
    && echo $TZ > /etc/timezone                         \
    && dpkg-reconfigure --frontend noninteractive tzdata

WORKDIR /thundercore

# This target builds the docker image
# This target can be useful to inspect the explicit outputs from the build,
FROM skeleton as build

ARG CTOOLS_BUILD="all"
ARG CTYPE="RelWithDebInfo"
ARG CCACHE_CPP2="true"
ARG CSCRIPTPCH="OFF"
ARG CSCRIPTS="static"
ARG CMODULES="static"
ARG CSCRIPTS_DEFAULT_LINKAGE="static"
ARG CWITH_WARNINGS="ON"
ARG CMAKE_EXTRA_OPTIONS=""
ARG GIT_DISCOVERY_ACROSS_FILESYSTEM=1

ARG CCACHE_DIR="/ccache"
ARG CCACHE_MAXSIZE="1000MB"
ARG CCACHE_SLOPPINESS="pch_defines,time_macros,include_file_mtime"
ARG CCACHE_COMPRESS=""
ARG CCACHE_COMPRESSLEVEL="9"
ARG CCACHE_COMPILERCHECK="content"
ARG CCACHE_LOGFILE=""

RUN apt-get update                                                     \
    && apt-get install -y --no-install-recommends                         \
        build-essential ccache libtool cmake-data make cmake clang    \
        git lsb-base curl unzip default-mysql-client openssl                  \
        default-libmysqlclient-dev libboost-all-dev libssl-dev libmysql++-dev \
        libreadline-dev zlib1g-dev libbz2-dev libncurses5-dev         \
    && rm -rf /var/lib/apt/lists/*

COPY CMakeLists.txt /thundercore/CMakeLists.txt
COPY conf /thundercore/conf
COPY deps /thundercore/deps
COPY src /thundercore/src
COPY modules /thundercore/modules

ARG CACHEBUST=1

WORKDIR /thundercore/build

RUN --mount=type=cache,target=/ccache,sharing=locked \
    # This may seem silly (and it is), but thunderCore wants the git repo at
    # build time. The git repo is _huge_ and it's not something that really
    # makes sense to mount into the container, but this way we can let the build
    # have the information it needs without including the hundreds of megabytes
    # of git repo into the container.
    --mount=type=bind,target=/thundercore/.git,source=.git \
    git config --global --add safe.directory /thundercore \
    && cmake /thundercore \
       -DCMAKE_INSTALL_PREFIX="/thundercore/env/dist"  \
       -DAPPS_BUILD="all"                              \
       -DTOOLS_BUILD="$CTOOLS_BUILD"                   \
       -DSCRIPTS="$CSCRIPTS"                           \
       -DMODULES="$CMODULES"                           \
       -DWITH_WARNINGS="$CWITH_WARNINGS"               \
       -DCMAKE_BUILD_TYPE="$CTYPE"                     \
       -DCMAKE_CXX_COMPILER="clang++"                  \
       -DCMAKE_C_COMPILER="clang"                      \
       -DCMAKE_CXX_COMPILER_LAUNCHER="ccache"          \
       -DCMAKE_C_COMPILER_LAUNCHER="ccache"            \
       -DBoost_USE_STATIC_LIBS="ON"                    \
    && cmake --build . --config "$CTYPE" -j $(($(nproc) + 1)) \
    && cmake --install . --config "$CTYPE"

#############################
# Base runtime for services #
#############################

FROM skeleton as runtime

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_USER=acore

ENV TCORE_COMPONENT=undefined

# Install base dependencies for thundercore
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libmysqlclient21 libreadline8 \
      gettext-base default-mysql-client && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /thundercore/env/dist/etc/ /thundercore/env/ref/etc

VOLUME /thundercore/env/dist/etc

ENV PATH="/thundercore/env/dist/bin:$PATH"

RUN groupadd --gid "$GROUP_ID"  "$DOCKER_USER" && \
    useradd -d /thundercore --uid "$USER_ID"  --gid "$GROUP_ID"  "$DOCKER_USER" && \
    passwd -d "$DOCKER_USER" && \
    chown -R "$DOCKER_USER:$DOCKER_USER" /thundercore

COPY --chown=$USER_ID:$GROUP_ID \
     --chmod=755 \
     apps/docker/entrypoint.sh /thundercore/entrypoint.sh

USER $DOCKER_USER

ENTRYPOINT ["/usr/bin/env", "bash", "/thundercore/entrypoint.sh"]

###############
# Login Server #
###############

FROM runtime as authserver
LABEL description "ThunderCore Auth Server"

ENV TCORE_COMPONENT=login
# Don't run database migrations. We can leave that up to the db-import container
ENV TC_UPDATES_ENABLE_DATABASES=0
# This disables user prompts. The console is still active, however
ENV TC_DISABLE_INTERACTIVE=1
ENV TC_CLOSE_IDLE_CONNECTIONS=0

COPY --chown=$DOCKER_USER:$DOCKER_USER \
     --from=build \
     /thundercore/env/dist/bin/authserver /thundercore/env/dist/bin/login


CMD ["login"]

################
# World #
################

FROM runtime as world

LABEL description "ThunderCore World"

ENV TCORE_COMPONENT=world
# Don't run database migrations. We can leave that up to the db-import container
ENV TC_UPDATES_ENABLE_DATABASES=0
# This disables user prompts. The console is still active, however
ENV TC_DISABLE_INTERACTIVE=1
ENV TC_CLOSE_IDLE_CONNECTIONS=0

COPY --chown=$DOCKER_USER:$DOCKER_USER \
     --from=build \
     /thundercore/env/dist/bin/worldserver /thundercore/env/dist/bin/worldserver

VOLUME /thundercore/env/dist/etc

CMD ["world"]

#############
# DB Import #
#############

FROM runtime as db-import

LABEL description "ThunderCore Database Import tool"

USER $DOCKER_USER

ENV TCORE_COMPONENT=dbimport

COPY --chown=$DOCKER_USER:$DOCKER_USER \
    data data

COPY --chown=$DOCKER_USER:$DOCKER_USER\
     --from=build \
     /thundercore/env/dist/bin/dbimport /thundercore/env/dist/bin/dbimport

CMD /thundercore/env/dist/bin/dbimport

###############
# Client Data #
###############

FROM skeleton as client-data

LABEL description="ThunderCore client-data"

ENV DATAPATH=/thundercore/env/dist/data

RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*

COPY --chown=$DOCKER_USER:$DOCKER_USER apps apps

VOLUME /thundercore/env/dist/data

USER $DOCKER_USER

CMD bash -c "source /thundercore/apps/installer/includes/functions.sh && inst_download_client_data"

##################
# Map Extractors #
##################

FROM runtime as tools

LABEL description "ThunderCore Tools"

WORKDIR /thundercore/env/dist/

RUN mkdir -pv /thundercore/env/dist/Cameras \
              /thundercore/env/dist/dbc     \
              /thundercore/env/dist/maps    \
              /thundercore/env/dist/mmaps   \
              /thundercore/env/dist/vmaps

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build \
  /thundercore/env/dist/bin/map_extractor /thundercore/env/dist/bin/map_extractor

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build \
  /thundercore/env/dist/bin/mmaps_generator /thundercore/env/dist/bin/mmaps_generator

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build \
  /thundercore/env/dist/bin/vmap4_assembler /thundercore/env/dist/bin/vmap4_assembler

COPY --chown=$DOCKER_USER:$DOCKER_USER --from=build \
  /thundercore/env/dist/bin/vmap4_extractor /thundercore/env/dist/bin/vmap4_extractor