-- 勝手にwifi(en1)が切断されて再接続しないので定期監視して再接続させる
-- SSID と PASSWORD を使う無線ネットに置き換えてください

set delayTime to 3 * 60

repeat
	try
		if (do shell script "ifconfig en1 | grep -c 'status: inactive'") = "1" then
			log (current date) & "wifi power off detected."
			do shell script "networksetup -setairportpower Wi-Fi on"
			log "wifi repowered...wait"
			delay 15
		end if
	end try
	try
		if ((do shell script "networksetup -getinfo Wi-Fi | grep -c 'IP address:'") = "1") or ((do shell script "networksetup -getairportnetwork en1 | grep -c 'You are not associated'") = "1") then
			log (log (current date) & "wifi network off detected.")
			do shell script "networksetup -setairportnetwork en1 SSID PASSWORD"
			log "wifi reconnected."
		end if
	end try
	log (current date) & "seems keeping connected."
	delay delayTime
	
end repeat


