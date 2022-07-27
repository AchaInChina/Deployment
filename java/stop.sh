#! /bin/sh
echo "in stop.sh"
basepath=$(cd `dirname $0`; pwd)
jarFullName=$(ls $basepath |grep ".jar$")
jar=${jarFullName##*/}
pid=`(ps -ef | grep $jar|grep java | grep -v "grep") | awk '{print $2}'`


function checkPidAlive {
 wwcl=$(/etc/alternatives/jps|grep ${pid}|wc -l)
 return $wwcl;
}

if [ ${pid} ];then
    kill $pid
    declare -i counter=0
        declare -i max_counter=15 # 15*2=30s
        declare -i total_time=0
        echo "waiting for ${jar} stop...pid="$pid
        while [[(counter -le max_counter)]]
        do
         printf "."
         counter+=1
         sleep 2
         checkPidAlive
         wwcl=$?
         if [[(wwcl -lt 1)]]; then
           printf "\n$(date) ${jar} has stoped\n"
           exit 0;
         fi
        done
        total_time=counter*3
    printf  "\n$(date) ${jarFullName}  has not stop success! total_time=$total_time\n"
    kill -9 $pid
    printf " *** has use: kill -9 $pid ***\n"
else
 printf "\n ************************************"
 printf "\n *** ${jarFullName} not run \n"
 printf "\n ************************************\n"
fi
