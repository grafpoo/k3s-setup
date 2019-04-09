### NOTE: vagrant docs say onfig.vm.provision shells will run as root, but my
###       experience here has not borne that out... except for this line here
###       so obviously i don't know what i am doing, but it seems to work
nohup k3s server 1>/tmp/k3s.log 2>&1 &
