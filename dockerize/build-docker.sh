#!/bin/bash
cd .. && docker build -t robot_control -f dockerize/Dockerfile . && cd dockerize
