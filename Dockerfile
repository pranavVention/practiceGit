FROM osrf/ros:humble-desktop as humble-base-image

# WORKDIR /home
# go to workspace
WORKDIR /root/workspace

RUN apt update

# Install zsh
RUN apt install -y zsh \
  && apt install -y wget \
  && sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
  -t robbyrussell

# Install Tools
RUN apt install vim -y\
    && apt install python3-pip -y\
    && pip3 install --upgrade pip\
    && apt install htop -y

#Update ROS dependencies
RUN rosdep update

# source global ros
RUN /bin/zsh -c "source /opt/ros/$ROS_DISTRO/setup.zsh"

#Autocomple for ROS2 and colcon
RUN echo 'eval "$(register-python-argcomplete3 ros2)"' >> /root/.zshrc
RUN echo 'eval "$(register-python-argcomplete3 colcon)"' >> /root/.zshrc


#Git PAT to clone private repos
ARG GIT_PAT
#Clone git repo and pass PAT
# RUN git clone https://${GIT_PAT}:<SSH Link here>

#Copy local files or folder to container
COPY ./README.md /home
