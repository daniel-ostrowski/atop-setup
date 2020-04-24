curl https://www.atoptool.nl/download/netatop-2.0.tar.gz -o netatop.tar.gz
gunzip netatop.tar.gz 
tar xf netatop.tar 
cd netatop-2.0/
sudo apt update && sudo apt install -y gcc make zlib1g-dev linux-headers-$(uname -r) atop speedtest-cli
sudo make
sudo make install
sudo /etc/init.d/netatop start
cd ..
echo "Network speed test:" >> baseline
speedtest-cli --simple >> baseline
echo "Maximum theoretical write speed (reading /dev/urandom):" >> baseline
dd if=/dev/urandom of=/dev/null count=1000000 2>> baseline
echo "Maximum disk write speed (reading /dev/urandom):" >> baseline
dd if=/dev/urandom of=kitbash count=1000000 2>> baseline
echo "Maximum theoretical read speed (writing /dev/null):" >> baseline
dd if=/dev/zero of=/dev/null count=1000000 2>> baseline
echo "Maximum disk read spead (writing /dev/null):" >> baseline
dd if=kitbash of=/dev/null 2>> baseline
sudo atop -w log 1 &
echo "You can now begin testing."
echo "When you finish testing, run the command:"
echo "sudo killall atop"
echo "Don't forget to scp the files /home/ubuntu/log and /home/ubuntu/baseline from this server back to your computer when you are done, otherwise you'll have to do this whole test all over again!"

