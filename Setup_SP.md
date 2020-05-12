Author : Shivam Mahesh Potdar, shivampotdar99[at]gmail.com, github.com/shivampotdar

Disclaimer: This might not be an extensive guide, I tried multiple methods on my system and noted down what worked for me.

Note : In the code snippets below, replace part between <...> as applicable in your machine.

##Download Code git repo
`git clone https://github.com/shivampotdar/cryoEM_synthetic_continua.git`

##Anaconda Setup
1. Install [anaconda distribution](https://docs.anaconda.com/anaconda/install/linux/)
2. Create a new *empty* anaconda virtual environment --> `conda create --name synth`

##Install the required packages for anaconda

3. Extract `synth_env_tars.zip`
4. Activate conda environment --> `conda activate synth`, and install all the packages using `conda install <path_to_your_folder>/synth_env_tars/*`

##Download additional software
It is suggested to make a new directory to download and install all the required packages, also it would be more convenient to specify this directory in all installer processes. 
This directory *must* be outside the git repository root directory.

###Chimera
5. Download [UCSF Chimera](https://www.cgl.ucsf.edu/chimera/download.html). 
(no license needed, but terms to be accepted, hence browser needed)
6. Run `chmod +x chimera-1.14-linux_x86_64.bin`, then `./chimera-1.14-linux_x86_64.bin`
7. Edit `~/.bashrc/` or `~/.zshrc` and add `export PATH="$PATH:"<chimera_install_directory>/Chimera/bin""`
8. `source .bashrc (or .zshrc)`
9. To use UCSF Chimera with Python scripts, use `pip2 install pychimera` (ensure that conda environment is *NOT* activated during this step)

###PyMOL
10. PyMOL based on Python2.7 is required for this code to run. Download using `wget https://pymol.org/installers/PyMOL-2.3.4_121-Linux-x86_64-py27.tar.bz2`
11. `tar -jxf PyMOL-2.3.4_121-Linux-x86_64-py27.tar.bz2`
12. `cd pymol` and `bash make-portable.sh` 
13. Edit `~/.bashrc/` or `~/.zshrc` and add `export PATH="$PATH:"<PyMOL_install_directory>/pymol/bin""`

##Phenix
14. Phenix can be downloaded [from](https://www.phenix-online.org/). Note that a download password has to be requested by filling a form. The credentials are valid till next Monday after you get access.
15. Extract with `tar xvf phenix-installer-1.18.1-3865-intel-linux-2.6-x86_64-centos6.tar.gz`
16. `cd phenix-installer-1.18.1-3865-intel-linux-2.6-x86_64-centos6` 
17. `./install --prefix <your_preferred_path>` . Installation can take few hours depending on your system.
18. The script will generate a line to be added to your ~/.bashrc file, copy paste that and restart shell.

###EMAN2
19. EMAN2 ver 2.12's _GUI_ depends on PyQt4, which is now obsolete and removed from all public repos, only way to get it working is building PyQt4 from source or updating the PyQt4-dependent code to PyQt5, both of which are considerably daunting tasks!
20. Nonetheless, the .mrc files needed for further steps can be successfully generated as the e2pdb2mrc module works via command line.
21. Download EMAN2.12 [from](https://cryoem.bcm.edu/cryoem/downloads/view_eman2_version/4)
22. `bash <path_to_EMAN2-installer>`
23. Add the necessary lines to `.bashrc / .zshrc`
24. EMAN2.12 depends on libdb, which can be installed with: 1. `sudo apt install libdb-dev` and 2. `~/anaconda3/envs/synth/bin/pip install bsddb3` (with the conda environment activated).

##For Relion
25. Relion alone can be built from source, but it requires GCC<=8. My system has 9.3.0 (Ubuntu 20.04). conda repositories have gcc 7.x but that again causes dependency issues.
26. Solution is to install CCPEM package instead [from](https://www.ccpem.ac.uk/download.php)
27. Extract and install using `./install_ccpem.sh`. It might show warning about CCP4 not being present, but Relion runs without that.
28. Add to .bashrc / .zshrc --> `source <install_path>/ccpem-1.4.1-linux-x86_64/ccpem-1.4.1/setup_ccpem.sh`


##Step 1
*Prerequisites:* anaconda environment setup, Chimera and pychimera
1. Now `cd` to the git repo (`<path>/cryoEM_synthetic_continuous`)
2. `conda activate synth`
3. `cd 1_Genstates_CM1` and run using `pychimera Gen_CM1.py`, outputs should be generated in `Generate_CM1` folder if everything went right :)

##Step 2
*Prerequisites:* PyMOL
1. From root dir of git repo, go to `2_GenStates_CM2`, 
2. `pymol -r Gen_CM2.py` , the screen might be just blank for few secs, it is due to ongoing process, it can be seen that terminal shows some activity. 
3. If run successfully, PyMOL window should show generated structure plus `Generate_CM2` directory would have 400 new files.

##Step 3
*Prerequisites:* Phenix
1. If Phenix is installed correctly, go to <git_repo>/3_ShiftPDB_Phenix, make necessary changes in the shell script as per readme. Please note the path changes are important, without that the script would still run but any outputs would not saved on your disk!
2. `sh ShiftPDB_phenix.sh` . 
3. This can take about 20 mins to run. Final outcome is 400 new files in 3_ShiftPDB_Phenix/PDB_shifts

##Step 4
*Prerequisites:* EMAN2
1. Switch to <git_root>/4_GenMRC_eman
2. Change the path in shell script (outFile=...) to match your system.
3. Run the script file! --> The ./MRCs folder would have 400 new files. (Note that these files are huge (~25GB) and you would need good amount of free space on the partition where scripts are running).

##Step 5
1. The versions of matplotlib and other graphics related libraries suggested with the package seem to have dependencies on old libraries. Trying to update them again results in dependency issues.
2. I worked around this by running those scripts through my system python2 (with conda environment deactivated). To do so, `pip install numpy matplotlib pylab scipy mrcfile`
3. Run scripts in 5_GenOcc_python using *system python* and *NOT* the conda environment.

##Step 6
1. Use same conditions as above for 6_GenClones_python

##Step 7
1. Use same conditions as above for 6_GenSTARs_python

##Step 8
*Prerequisites:* Relion (through CCPEM)
1. Make necessary path changes in path in the relion_projCTF.sh script.
2. `./relion_projCTF.sh` (setup_ccpem.sh (above) must be sourced for this to work)

Did not work directly, so installed numpy, matplotlib, pylab, scipy and mrcfiles on system pip2. 


For EMAN2.12 --> PyQt4 we dont have.  and 



