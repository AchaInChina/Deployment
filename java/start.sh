#! /bin/sh
echo "in start.sh"
basepath=$(cd `dirname $0`; pwd)
cd $basepath
jarFullName=$(ls $basepath|grep ".jar$")
jar=${jarFullName##*/}

pid=`(ps -ef | grep $jar|grep java | grep -v "grep") | awk '{print $2}'`
if [ ${pid} ];then
  printf "\n *************************ERROR*******************\n"
  printf "\n\n ERROR,ERROR, ${jar} is running,cannot start again...you must stop it first.  \n\n"
  printf "\n *************************ERROR*******************\n"
  exit 0;
fi

nohup java -Xms512M -Xmx2048M  -jar $jar &
echo ${jarFullName}" starting ... ... "
sleep 2
pid=`(ps -ef | grep $jar|grep java | grep -v "grep") | awk '{print $2}'`

if [ ${pid} ];then
    printf "\n ---------------------------------------"
    printf "\n *** ${jarFullName} Start OK!!!!pid=${pid} \n"
    printf "\n ---------------------------------------\n"
else 
    printf "\n ************************************"
    printf "\n *** ${jarFullName} Start FAIL FAIL FAIL!!!! \n"
    printf "\n ************************************\n"
fi
