#!/bin/bash
test=$(lsb_release -sc)
echo "${test}"
if [ "${test}" == "bionic" ]; then
        echo "Ubuntu verison Check...."
else
        lsb_release -a
        echo "this bash is built for Ubuntu 18.04 bionic. Your system is Ubuntu:" ${test} 
        read -p "Do you want to continue?(Y/n)" yn
        if [ "${yn}" != "Y" ]; then
                exit
        fi
fi


#Setup sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
#Set up keys
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

#Installation ROS
sudo apt update
sudo apt install -y ros-melodic-desktop-full

#Environment setup
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc

#Dependencies for building packages
sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential

#Initialize rosdep
sudo rosdep init
rosdep update

#setup workspace
mkdir -p ~/catkin_ws/src;
cd ~/catkin_ws/;
catkin_make;
rosversion ros;
source devel/setup.bash;
echo "Your ROS package:" $ROS_PACKAGE_PATH
