# Aliases
#alias ls='ls -alh --color=auto'
alias ls='ls -X --color=auto'
alias el1='ssh -Y el1.hpc.nrel.gov'
alias el2='ssh -Y el2.hpc.nrel.gov'
alias el3='ssh -Y el3.hpc.nrel.gov'
alias ed1='ssh -Y ed1.hpc.nrel.gov'
alias ed2='ssh -Y ed2.hpc.nrel.gov'
alias ed3='ssh -Y ed3.hpc.nrel.gov'

alias mmc='cd /projects/mmc'
alias swift='cd /projects/mmc/SWIFTRegion/8Nov2013'
alias scratch='cd /scratch/dallaert'
alias mstorage='cd /mss/users/dallaert'
alias mmc_storage='cd /mss/projects/mmc'

alias vi='vim'

#alias dshowq='squeue -u dallaert -l'
alias dshowq='squeue -u dallaert --Format="JobID,partition,name:30,state,timeused,timelimit,numnodes"'
#alias dsinfo='sinfo -o %A'
alias dsinfo="sinfo -o '%24P %.5a  %.12l  %.16F'"
alias dsinfol="sinfo -o '%24P %.5a  %.12l  %.16F %T'"

alias qme='watch -n 1 "qstat -u dallaert"'
alias goparaview='Paraview-5.0.0 && vglrun paraview'
alias py='python'
alias ipy='ipython'
alias newpy='cp /home/dallaert/pytools/templates/templatePythonScriptSerial.py '
alias newpypar='cp /home/dallaert/pytools/templates/templatePythonScriptParallel.py '
alias hipy='sourcePYTHON3'
alias byepy='source deactivate'
