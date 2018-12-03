# Aliases
#alias ls='ls -alh --color=auto'
alias ls='ls -X --color=auto'
alias pg1='ssh -Y peregrine-login1.hpc.nrel.gov'
alias pg2='ssh -Y peregrine-login2.hpc.nrel.gov'
alias pg3='ssh -Y peregrine-login3.hpc.nrel.gov'
alias pg4='ssh -Y peregrine-login4.hpc.nrel.gov'
#alias dav1='ssh -Y dav1.hpc.nrel.gov'
#alias dav2='ssh -Y dav2.hpc.nrel.gov'
#alias dav3='ssh -Y dav3.hpc.nrel.gov'
alias dav4='ssh -Y dav4.hpc.nrel.gov'
alias dav6='ssh -Y dav6.hpc.nrel.gov'

alias mmc='cd /projects/mmc'
alias scratch='cd /scratch/dallaert'
alias mstorage='cd /mss/users/dallaert'
alias mmc_storage='cd /mss/projects/mmc'
alias src='cd /home/dallaert/OpenFOAM'

alias vi='vim'

alias dqstat='qstat -u dallaert'
alias dshowq='showq -u dallaert'

#alias interactiveJobShort24='qsub -I -l nodes=1:ppn=24,walltime=4:00:00 -q short -A mmc'
#alias interactiveJobShort32='qsub -I -l nodes=2:ppn=16,walltime=4:00:00,feature=16core -q short -A mmc'
#alias interactiveJobShort48='qsub -I -l nodes=2:ppn=24,walltime=4:00:00 -q short -A mmc'
#alias interactiveJobShort72='qsub -I -l nodes=3:ppn=24,walltime=4:00:00 -q short -A mmc'
#alias interactiveJobShort96='qsub -I -l nodes=4:ppn=24,walltime=4:00:00 -q short -A mmc'
#alias interactiveJobShort24BigMem='qsub -I -l nodes=4:ppn=24,walltime=4:00:00,feature=256GB -q short -A mmc'
#alias interactiveJob24='qsub -I -l nodes=1:ppn=24,walltime=48:00:00 -q batch-h -A mmc'

alias interactiveDataTransfer='qsub -I -l nodes=1,walltime=12:00:00 -q data-transfer -A mmc'


alias qme='watch -n 1 "qstat -u dallaert"'
alias goparaview='Paraview-5.0.0 && vglrun paraview'
alias py='python'
alias ipy='ipython'
alias newpy='cp /home/dallaert/pytools/templates/templatePythonScriptSerial.py '
alias newpypar='cp /home/dallaert/pytools/templates/templatePythonScriptParallel.py '
alias hipy='sourcePYTHON3'
alias byepy='source deactivate'
