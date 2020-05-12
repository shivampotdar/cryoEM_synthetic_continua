for i in /mnt/Shivam/SelfLearning/Projects/2020.4_ETH/git/cryoEM_synthetic_continua/6_GenClones_python/MRC_clones/*.mrc
do
    out=`basename $i`
    angFile=/mnt/Shivam/SelfLearning/Projects/2020.4_ETH/git/cryoEM_synthetic_continua/7_GenSTARs_python/STARs/proj812_${out%.*}.star
    outFile=/mnt/Shivam/SelfLearning/Projects/2020.4_ETH/git/cryoEM_synthetic_continua/8_GenStacksCTF_relion/stacks/${out%.*}
    echo $outFile
    relion_project --i "${i}" --o $outFile --ang $angFile --ctf true --angpix 1
done
