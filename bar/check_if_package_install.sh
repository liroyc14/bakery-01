#!/usr/bin/bash
<<<<<<< HEAD

=======
>>>>>>> 067ab65777a484a616dee5fb96f9b9c096e4122c
if [[ $? -eq 0 ]]; then
    echo "ncdu installed"
    exit 0
fi
<<<<<<< HEAD

=======
>>>>>>> 067ab65777a484a616dee5fb96f9b9c096e4122c
read -p "ncdu is not install. do you want to install it ? [y/n]" user_ans
if [[ user_ans == "y" ]]; then
    yum install -y ncdu
elif [[ $user_ans == "n" ]];  then
    echo "not install it"
else
    echo "Invaild answer"
fi
