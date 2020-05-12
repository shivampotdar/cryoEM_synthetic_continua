# script to re-center all PDBs based on common center-of-mass coordinates

for i in ../2_GenStates_CM2/Generate_CM2/*.pdb
do
    out=`basename $i`
    outFile=/mnt/Shivam/SelfLearning/Projects/2020.4_ETH/git/cryoEM_synthetic_continua/3_ShiftPDB_phenix/PDB_shifts/$out
    echo "$outFile"
    phenix.pdbtools "${i}" output.file_name=$outFile sites.translate="115.5 58.1 -39.5" #replace with CoM of your state_01_01.pdb
done

