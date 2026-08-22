#!/bin/bash

set -e

echo "=================================="
echo " ZC Marine Robotics Gazebo Test"
echo "=================================="

echo ""
echo "Checking ROS 2..."
ros2 --version

echo ""
echo "Checking Gazebo..."
gz sim --version

echo ""
echo "Checking ROS-Gazebo packages..."
ros2 pkg list | grep ros_gz

echo ""
echo "=================================="
echo " Gazebo environment OK!"
echo "=================================="
