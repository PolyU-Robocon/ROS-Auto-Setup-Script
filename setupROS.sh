test=$(lsb_release -sc)
echo "${test}"
echo "Ubuntu verison Check...."
if [ "${test}" == "focal" ]; then
        ros_install=
        echo "Ubuntu verison Check...."
        lsb_release -a
        echo "Your system is Ubuntu: ${test} , the bash wil install ROS"
        read -p "Do you want to continue?(Y/n)" yn
        if [ "${yn}" != "Y" ]; then
                exit
        fi
else

fi
