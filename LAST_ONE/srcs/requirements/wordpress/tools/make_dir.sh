#!/bin/bash

#if there's no dolder data in User folder - create such
#with subfolders for WP and DB
if [ ! -d "/home/${USER}/data" ]; then
        mkdir ~/data
        mkdir ~/data/mariadb
        mkdir ~/data/wordpress
fi
