#!/bin/bash

sudo docker build -t beginnerfuzz .
sudo docker run --tty beginnerfuzz
