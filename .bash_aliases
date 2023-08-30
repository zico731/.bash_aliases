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
x() { [ -f $1 ] && nano -l +$(wc -l<a),$(tail -1 a| wc -c) $1 || echo -e '#!/bin/bash\n#'"$(date "+%A %d %B %Y %H:%M")"'\n#Francois\n\n' > $1 && chmod +x $1 && nano -l +5 $1 ; }

# fonction qui génère un fichier exécutable python3 portant le nom $1 puis lance l'édition sinon ouvre le fichier déjà existant
xp() { [ -f $1 ] && nano -l +$(wc -l<a),$(tail -1 a| wc -c) $1 || echo '#!/usr/bin/env python3' > $1 && chmod +x $1 && nano -l +2 $1 ; }

# Trouver le paquet qui a installé une commande et la date d’installation de ce paquet
paquetinfo() { which "$@"   | xargs -r readlink -f | xargs -r dpkg -S && zgrep -h "installed " /var/log/dpkg.log* | sort | grep "$@" ;}

# Converti une chaine en MINUSCULE
MIN() { echo ${@,,} ; }

# Converti une chaine en MAJUSCULE
MAJ() { echo ${@^^} ; }

# Converti une chaine en MINUSCULE puis met la 1ere lettre en MAJUSCULE
CAP() { temp=$(MIN "${@}") && echo "${temp^}" ; }

# quel âge a Milo ?
milo()  { cat /tmp/milo2ascii && echo Milo a $(($((`date +%s`-`date +%s --date 08/21/2019`))/86400)) jours | figlet -f script ; }

# scraping de gratilog.net 
gratilog() { curl www.gratilog.net 2>/dev/null | awk '/Les 50/,/Liens r/'|html2text| sed -e '$d' -e 's/:: //' ;}

# meteo <ville>
meteo() { curl fr.wttr.in/${1:-beziers} ;}

# mot : cherche un mot au hazard dans le dictonnaire, requis : hunspell
mot() { cat /usr/share/hunspell/fr_FR.dic|shuf -n1| cut -d '/' -f1| awk '{print $1}' ;}

# traduire à partir d'une chaine ou d'une url en francais
francais() { trans -b :fr -no-auto "$*" ;}

# file.jpg --> file.png (avec transparence) afin d'intégrer cette signature dans un pdf     
signature() { convert "$1" png:- | convert - -fuzz 20% -transparent white ${1%%.*}.png ;}

# optimise la taille d'un pdf
pdf_compress() { gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${1%%.*}_reduit.pdf" "$1" &&  printf "Réduction: %s octets --> %s octets\n" $(stat -c %s "$1") $(stat -c %s "${1%%.*}_reduit.pdf" ) ;}

# envoie un sms qui contient comme message $1 (USAGE: a intégrer dans un script afin d'etre informer d un resultat)
sms_info() { msg=$(echo "$HOSTNAME : $1"|sed 's/\s/%20/g') ; user=18924628 ; passwd=D81jWwFsP99ODa ; /usr/bin/curl -G "https://smsapi.free-mobile.fr/sendmsg?user=${user}&pass=${passwd}&msg=${msg}" ; }

# transferer un fichier en ligne afin de le récupérer sur une autre machine --> renvoie une adresse de recuperation (USAGE: upload /path/of/file)
upload() { curl --upload-file "$1" "https://transfer.sh/$1"; echo ; }

# récupérartion d'un fichier stocké en ligne grace a son url généré, (USAGE: download http://url/of/tranfert.sh [filename])
download() { curl $1 -o ${2:-$(basename $1)} ;}


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
alias maj='apt update  && apt full-upgrade -y && apt clean && apt autoremove --purge -y'
alias l2='ls -lAtr'
alias tv='tidy-viewer' #visionneuse de csv
alias fav='bat /root/.bash_aliases' #affiche mes commandes et alias
alias compare='colordiff -yW"`tput cols`"' 
alias pastebin="curl -F 'sprunge=<-' http://sprunge.us <<<"
alias uc='(read chaine; curl -s --data "text=$chaine" https://file.io | jq -r .link ) <<< '                                         
alias uf='(read fichier; curl -sF "file=@$fichier" https://file.io | jq -r .link ) <<< '
