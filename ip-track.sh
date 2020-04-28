#!/bin/bash
trap 'printf "\n";stop;exit 1' 2
printf '''\e[1;92m
              (
               )
              (
        /\  .-"""-.  /\
       //\\/  ,,,  \//\\
       |/\| ,;;;;;, |/\|
       //\\\;-"""-;///\\ \e[1;93m
      //  \/   .   \/  \\
     (| ,-_| \ | / |_-, |)
       //`__\.-.-./__`\\ \
      // /.-(() ())-.\ \\
     (\ |)   '---'   (| /)
      ` (|           |) `
        \)           (/

'''
start() {
command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
if [[ -e ip.txt ]]; then
rm -rf ip.txt

fi
printf "\e[1;93m[\e[0m*\e[1;93m] Name    : IP Tracker \n"   
printf "\e[1;94m[\e[0m*\e[1;94m] Thanks  : @thelinuxchoice \n"
printf "\e[1;95m[\e[0m*\e[1;95m] Thanks  : Victor Stanciu \n"
printf "\e[1;96m[\e[0m*\e[1;96m] Moded   : Mr.silent coder \n"
printf "\e[1;31m[\e[0m*\e[1;31m] Warning : Stay Legal! \n\n"
printf "\e[1;92m[\e[0m*\e[1;92m] Open Ngrok http port 80 \n" 
printf "\e[1;92m[\e[0m*\e[1;92m] ex: ngrok http 80 \n" 
printf "\e[1;92m[\e[0m*\e[1;92m] Starting php server...\n"
sudo php -S "localhost:80" > /dev/null 2>&1 & 
sleep 2
printf "\e[1;92m[\e[0m*\e[1;92m] Send Ngrok link to the Victim\e[0m\e[1;77m %s\e[0m\n" 

printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Waiting victim open the link ...\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m*\e[1;92m] IP Found!\n"
catch_ip
break
  fi
sleep 1
done 

}

catch_ip(){

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
os=$(grep 'OS:' ip.txt | cut -d " " -f2)
IFS=$'\n'
bsr=$(grep 'Browser:' ip.txt | cut -d " " -f2)
IFS=$'\n'
uaget=$(grep 'User_agent:' ip.txt | cut -d '"' -f2)
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Victim IP:\e[0m\e[1;77m %s\e[0m\n" $ip
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Victim OS:\e[0m\e[1;77m %s\e[0m\n" $os
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Victim Browser:\e[0m\e[1;77m %s\e[0m\n" $bsr
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m]\e[0m\e[1;77m %s\e[0m\n" $uaget
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Saved:\e[0m\e[1;77m %s/saved.ip.txt\e[0m\n" $server
cat ip.txt >> saved.ip.txt
killall -2 php > /dev/null 2>&1
exit 1
}

stop() {


checkphp=$(ps aux | grep -o "php" | head -n1)

if [[ $checkphp == *'php'* ]]; then
pkill -f -2 php > /dev/null 2>&1
killall -2 php > /dev/null 2>&1
fi


}

start
