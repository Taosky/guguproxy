if [ -e hd.txt ]; then
    exit
fi
arr=()

for i in {1..25}
do
    sleep 1
    arr+=($(curl -H 'accept: application/dns-json' https://1.1.1.1/dns-query\?name\=www.google.com | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'))
done
arr=($(awk -v RS=' ' '!a[$1]++' <<< ${arr[@]}))
printf "%s\n" "upstream www.google.com {" > hd.txt
printf "  server %s:443;\n" "${arr[@]}" >> hd.txt
printf "%s\n" "}" >> hd.txt
cp /etc/nginx/conf.d/google.conf  temp.conf
cat hd.txt temp.conf > /etc/nginx/conf.d/google.conf
