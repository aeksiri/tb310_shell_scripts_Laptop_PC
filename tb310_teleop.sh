#! /bin/bash

#kill in TB3
ssh tb310@10.42.0.110 'killall -9 bash'
ssh tb310@10.42.0.110 'killall -9 bringup.sh'
ssh tb310@10.42.0.110 'killall -9 python'
ssh tb310@10.42.0.110 'killall -9 hlds_laser_publisher'
ssh tb310@10.42.0.110 'killall -9 turtlebot3_diagnostics'
ssh tb310@10.42.0.110 'killall -9 sshd'
ssh tb310@10.42.0.110 'killall -9 raspi_camera.sh'
ssh tb310@10.42.0.110 'killall -9 roslaunch'
ssh tb310@10.42.0.110 'killall -9 raspicam_node'

#Kill in LAPTOP
killall -9 ssh
killall -9 roslaunch
killall -9 rosout
killall -9 rosmaster

#source files
source /opt/ros/kinetic/setup.bash

source ~/catkin_ws/devel/setup.bash

#rosmaster
roscore &

sleep 5

#raspi_camera
ssh tb310@10.42.0.110 'source /opt/ros/kinetic/setup.bash && export ROS_MASTER_URI=http://10.42.0.1:11311 && export ROS_HOSTNAME=10.42.0.110 && source ~/catkin_ws/devel/setup.bash && ~/catkin_ws/src/tb3_shell_scripts/./raspi_camera.sh' &

sleep 10

#image
rqt_image_view &

sleep 5

#bringup in TB3
ssh tb310@10.42.0.110 'source /opt/ros/kinetic/setup.bash && export ROS_MASTER_URI=http://10.42.0.1:11311 && export ROS_HOSTNAME=10.42.0.110 && export TURTLEBOT3_MODEL=burger && source ~/catkin_ws/devel/setup.bash && ~/catkin_ws/src/tb3_shell_scripts/./bringup.sh' &

sleep 12

roslaunch turtlebot3_teleop turtlebot3_teleop_key.launch 

#kill in TB3
ssh tb310@10.42.0.110 'killall -9 bash'
ssh tb310@10.42.0.110 'killall -9 bringup.sh'
ssh tb310@10.42.0.110 'killall -9 python'
ssh tb310@10.42.0.110 'killall -9 hlds_laser_publisher'
ssh tb310@10.42.0.110 'killall -9 turtlebot3_diagnostics'
ssh tb310@10.42.0.110 'killall -9 sshd'
ssh tb310@10.42.0.110 'killall -9 raspi_camera.sh'
ssh tb310@10.42.0.110 'killall -9 roslaunch'
ssh tb310@10.42.0.110 'killall -9 raspicam_node'

#kill in LAPTOP
killall -9 ssh
killall -9 roslaunch
killall -9 rosout
killall -9 rosmaster

echo "teleop Completed!!!"
