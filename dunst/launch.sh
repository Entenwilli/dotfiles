#!/bin/bash

pkill dunst
dunst -config /home/felix/.config/dunst/dunstrc | tee -a /tmp/dunst.log&
