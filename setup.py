from setuptools import setup, find_packages
from setuptools.command.install import install
from distutils.dir_util import copy_tree
import os
import shutil

# global variables
board = os.environ['BOARD']
repo_proj_folder = f'boards/{board}'
lib_folder = 'libs'
board_notebooks_dir = os.environ['PYNQ_JUPYTER_NOTEBOOKS']
hw_data_files = []

# check whether board is supported
def check_env(repo_board_folder):
    if not os.path.isdir(repo_board_folder):
        raise ValueError("Board {} is not supported., as {} directory does not exist".format(board, repo_board_folder))
    if not os.path.isdir(board_notebooks_dir):
        raise ValueError("Directory {} does not exist.".format(board_notebooks_dir))

# copy overlays to python package
def copy_overlays(repo_board_folder, ovl_dest):
    src_ol_dir = os.path.join(repo_board_folder, 'bitstream')
    dst_ol_dir = os.path.join(ovl_dest, 'bitstream')
    copy_tree(src_ol_dir, dst_ol_dir)
    hw_data_files.extend([os.path.join("..", dst_ol_dir, f) for f in os.listdir(dst_ol_dir)])

# copy notebooks to jupyter home
def copy_notebooks(repo_board_folder, ovl_dest):
    src_nb_dir = os.path.join(repo_board_folder, 'notebook')
    dst_nb_dir = os.path.join(board_notebooks_dir, ovl_dest)
    if os.path.exists(dst_nb_dir):
        shutil.rmtree(dst_nb_dir)
    copy_tree(src_nb_dir, dst_nb_dir)

# copy libs to pynq/lib
def copy_libs():
    src_lib_dir = os.path.join('.', 'libs')
    dst_lib_dir = os.path.join('.', 'libs')
    if os.path.exists(dst_lib_dir):
        shutil.rmtree(dst_lib_dir)
    copy_tree(src_lib_dir, dst_lib_dir)

subfolders = [ f.name for f in os.scandir(repo_proj_folder) if f.is_dir() ]
for proj in subfolders:
	print(proj)
	if(proj=="pip-egg-info"):
		continue
	repo_board_folder = f'boards/{board}/'+proj
	ovl_dest = proj
	check_env(repo_board_folder)
	copy_overlays(repo_board_folder, ovl_dest)
	copy_notebooks(repo_board_folder, ovl_dest)
	copy_libs()

setup(
	name= "pynq_overlays",
	version= "1.0",
	url= 'https://github.com/imec-int/pynq_overlays.git',
	license = 'Apache Software License',
	author= "Wouter Devriese",
	author_email= "wouter.devriese@imec.be",
	packages= find_packages(),
	package_data= {
	 '': hw_data_files,
	},
	description= "library for pynq overlay packages",
)
