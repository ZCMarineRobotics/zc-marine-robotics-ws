#!/bin/bash

set -e

echo "=================================="
echo " ZC Marine Robotics Gazebo Test"
echo "=================================="

echo ""
echo "Checking ROS 2..."

source /opt/ros/lyrical/setup.bash

command -v ros2

echo "ROS 2: OK"

echo ""
echo "Checking Gazebo..."

gz sim --version

echo "Gazebo: OK"

echo ""
echo "Checking ROS-Gazebo packages..."

ros2 pkg list | grep -q "^ros_gz_bridge$"
echo "ros_gz_bridge: OK"

ros2 pkg list | grep -q "^ros_gz_sim$"
echo "ros_gz_sim: OK"

ros2 pkg list | grep -q "^ros_gz_interfaces$"
echo "ros_gz_interfaces: OK"

echo ""
echo "=================================="
echo " Gazebo test PASSED"
echo "=================================="
