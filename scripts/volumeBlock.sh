#!/bin/bash

pavucontrol
color=$(xrdb -query | grep '*color5'| awk '{print $NF}')


