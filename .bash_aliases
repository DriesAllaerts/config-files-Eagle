# .bash_aliases file containing custom aliases

# Use vim instead of vi
alias vi='vim'

alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -alF'
#alias ls='ls -alh --color=auto'

alias el1='ssh -Y el1.hpc.nrel.gov'
alias el2='ssh -Y el2.hpc.nrel.gov'
alias el3='ssh -Y el3.hpc.nrel.gov'
alias ed1='ssh -Y ed1.hpc.nrel.gov'
alias ed2='ssh -Y ed2.hpc.nrel.gov'
alias ed3='ssh -Y ed3.hpc.nrel.gov'

alias mmc='cd /projects/mmc'
alias swift='cd /projects/mmc/SWIFTRegion/8Nov2013'
alias scratch='cd /scratch/$USER'
alias mstorage='cd /mss/users/$USER'
alias mmc_storage='cd /mss/projects/mmc'

#alias dshowq='squeue -u $USER -l'
alias dshowq='squeue -u $USER --Format="JobID,partition,name:30,state,timeused,timelimit,numnodes"'
#alias dsinfo='sinfo -o %A'
alias dsinfo="sinfo -o '%24P %.5a  %.12l  %.16F'"
alias dsinfol="sinfo -o '%24P %.5a  %.12l  %.16F %T'"

alias qme='watch -n 1 "qstat -u $USER"'
alias goparaview='Paraview-5.0.0 && vglrun paraview'
alias py='python'
alias ipy='ipython'
alias newpy='cp /home/$USER/pytools/templates/templatePythonScriptSerial.py '
alias newpypar='cp /home/$USER/pytools/templates/templatePythonScriptParallel.py '
alias hipy='sourcePYTHON3'
alias byepy='source deactivate'

alias touchall='find . -type f -exec touch {} +'
