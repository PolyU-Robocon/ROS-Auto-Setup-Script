#!/bin/bash

Pink='\033[38;5;198m' #BullyU favorite color
NC='\033[0m' # No Color

setupROSworkspace()
{
  #toolneeded
  sudo apt-get install python-catkin-tools python-rosinstall-generator
  
  #setup workspace
  mkdir -p ~/catkin_ws/src;
  cd ~/catkin_ws/;
  catkin init;
  catkin_make;
  wstool init src;
  rosversion ros;
  source devel/setup.bash;
  echo "Your ROS package:" $ROS_PACKAGE_PATH
}

setupMelodic()
{
  echo "Ubuntu verison Check...."
  lsb_release -a
  echo -e "this bash is built for ${Pink}Ubuntu 18.0x with ROS Melodic${NC}. Your system is Ubuntu:" ${Pink} ${test} ${NC}
  read -p "Do you want to continue?(Y/n)" yn
  if [ "${yn}" != "Y" ]; then
    return 1 
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
  
  #install Dependencies for building packages
  sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential;
  sudo apt install -y python-rosdep python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential;

  #Initialize rosdep
  sudo rosdep init;
  rosdep update;
  
  #Setup Workspace
  setupROSworkspace
}

setupNoetic()
{
  echo "Ubuntu verison Check...."
  lsb_release -a
  echo -e "this bash is built for ${Pink}Ubuntu 20.0x with ROS Noetic${NC}. Your system is Ubuntu:" ${Pink} ${test} ${NC}
  read -p "Do you want to continue?(Y/n)" yn
  if [ "${yn}" != "Y" ]; then
    return 1 
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
  
  #Setup Workspace
  setupROSworkspace
}

test=$(lsb_release -sc)
echo "${test}"
if [ "${test}" == "focal" ]; then
  setupNoetic
fi
if [ "${test}" == "bionic" ]; then
  setupMelodic
fi
