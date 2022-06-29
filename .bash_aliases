# -------------------- PERSO ------------------------

# --- FONCTIONS ---

# Hexadécimal vers décimal
h2d(){
  echo "ibase=16; $@" | tr -s ' ' ';' | bc
}
# Décimal vers hexadécimal
d2h(){
  echo "obase=16; $@" | tr -s ' ' ';' | bc
}

# Binaire vers décimal
b2d(){
  echo "ibase=2; $@" | tr -s ' ' ';' | bc
}
# Décimal vers binaire
d2b(){

 echo "obase=2; $@" | tr -s ' ' ';' | bc
}

#  ipv4 en ip_binaire formaté 00000000.00000000.00000000.00000000
ipd2b(){
IFS="."; set --  $@
printf "%08d.%08d.%08d.%08d\n" $(d2b $1) $(d2b $2) $(d2b $3) $(d2b $4)
}

# fonction qui génère un fichier exécutable portant le nom $1 puis lance l'édition sinon ouvre le fichier déjà existant
x() { [ -f $1 ] && nano -l +$(wc -l<a),$(tail -1 a| wc -c) $1 || echo '#!/bin/bash' > $1 && chmod +x $1 && nano -l +2 $1 ; }

# fonction qui génère un fichier exécutable Python3 portant le nom $1 puis lance l'édition sinon ouvre le fichier déjà existant
xp() { [ -f $1 ] && nano -l +$(wc -l<a),$(tail -1 a| wc -c) $1 || echo '#!/usr/bin/env python3' > $1 && chmod +x $1 && nano -l +2 $1 ; }

# en MINUSCULE
MIN() { echo ${@,,} ; }

# en MAJUSCULE
MAJ() { echo ${@^^} ; }

# quel âge a milo ?
milo()  { cat /tmp/milo2ascii && echo Milo a $(($((`date +%s`-`date +%s --date 08/21/2019`))/86400)) jours | figlet -f script ; }

# scraping de gratilog.net 
gratilog() { curl www.gratilog.net 2>/dev/null | awk '/Les 50/,/Liens r/'|html2text| sed -e '$d' -e 's/:: //' ;}

# meteo <ville>
meteo() { curl wttr.in/$1 ;}

# mot : cherche un mot au hazard dans le dictonnaire, requis : hunspell
mot() { cat /usr/share/hunspell/fr_FR.dic|shuf -n1| cut -d '/' -f1| awk '{print $1}' ;}

# traduire à partir d'une chaine ou d'une url en francais
francais() { trans -b :fr -no-auto "$1" ;}

# file.jpg --> file.png (avec transparence) afin d'intégrer cette signature dans un pdf     
signature() { convert "$1" png:- | convert - -fuzz 20% -transparent white ${1%%.*}.png ;}

# optimise la taille d'un pdf
pdf_compress() { gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${1%%.*}_reduit.pdf" "$1" &&  printf "Réduction: %s octets --> %s octets\n" $(stat -c %s "$1") $(stat -c %s "${1%%.*}_reduit.pdf" ) ;}


# --- HISTORIQUE HEURODATE ---
EXTENDED_HISTORY=ON
export EXTENDED_HISTORY
HISTTIMEFORMAT="%F %T : "
export HISTIMEFORMAT
HISTCONTROL="ignoredups:ignorespace"
shopt -s histappend

# --- PATH ---
export PATH=$PATH:/tmp


# --- ALIAS ---
alias h="history"
alias hg="history|grep"
alias maj='apt update -y && apt upgrade -y'
alias l2='ls -lAtr'
alias tv='tidy-viewer' #visionneuse de csv
