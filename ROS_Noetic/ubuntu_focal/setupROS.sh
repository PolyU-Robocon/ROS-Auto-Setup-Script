#!/bin/bash
test=$(lsb_release -sc)
echo "${test}"
if [ "${test}" == "focal" ]; then
        echo "Ubuntu verison Check...."
else
        lsb_release -a
        echo "this bash is built for Ubuntu 20.0x noetic. Your system is Ubuntu:" ${test} 
        read -p "Do you want to continue?(Y/n)" yn
        if [ "${yn}" != "Y" ]; then
                exit
        fi
fi

#pre config before intall
#sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list';
#Add key 
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654;

#install
sudo apt update -y;
sudo apt install -y ros-noetic-desktop-full;


source /opt/ros/noetic/setup.bash;
#add this script every time a new shell is launched
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc;
source ~/.bashrc;

#install Dependencies for building packages
sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential;
sudo apt install -y python3-rosdep;

#Initialize rosdep
sudo rosdep init;
rosdep update;

#setup workspace
mkdir -p ~/catkin_ws/src;
cd ~/catkin_ws/;
catkin_make;
rosversion ros;
source devel/setup.bash;
echo "Your ROS package:" $ROS_PACKAGE_PATH

