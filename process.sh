start_cfd()
{
	echo "tunnel" > args

	echo "--metrics 0.0.0.0:$CLOUDFLARED_METRICS_PORT" >> args
	echo "--no-autoupdate" >> args
	echo "--management-diagnostics=false" >> args

	cat "$CLOUDFLARED_EXTRA_ARGS_FILE" >> args

	echo "run" >> args

	TUNNEL_TOKEN=$(cat $CLOUDFLARED_TOKEN_FILE) \
		xargs ./cloudflared < args \
		&
}

stop_cfd()
{
	timeout 3 killall -w -2 cloudflared 2>/dev/null || killall -9 cloudflared 2>/dev/null || echo "PROCESS: tunnel is already stopped"
}

read cmd
case $cmd in
	cfd-start)
		echo "PROCESS: starting"
		start_cfd
		;;
	cfd-stop)
		echo "PROCESS: stopping"
		stop_cfd
		;;
	cfd-restart)
		echo "PROCESS: restarting"
		stop_cfd
		start_cfd
		;;
esac
