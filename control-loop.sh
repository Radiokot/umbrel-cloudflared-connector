trap "echo CONTROL: exiting; killall -w -2 cloudflared; exit;" INT TERM

echo cfd-start | sh process.sh
while true 
do 
	sh accept.sh | sh process.sh
done

