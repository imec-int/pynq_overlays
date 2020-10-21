# pynq_overlays
repository for pynq packages

usage: on the development board, install the packages by opening a jupyter terminal (root access):

`sudo pip3 install --upgrade git+https://github.com/imec-int/pynq_overlays.git`


## folder structure

1. per project, one should make a folder with only an __init__.py file.
2. boards
3. libs

## boards
In this folder we'll list the development boards/builds for chipsets with per pproject their bitstreams, tcl files & notebooks

### bitstream files

place following files:

* .bit
* .tcl (written with block diagram open via `write\_bd\_tcl <name>.tcl
* .hwh
* .xsa
* .xdc the constraint file (not necessarry, yet comes in handy)

### notebook

place here the exemplary notebook for the project


## libs
in this folder we'll locate the IP libraries for custom IPs used in the notebooks
