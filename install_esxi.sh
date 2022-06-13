#!/bin/bash
version=0.1
II=VMware-VMvisor-Installer-6.5.0.update03-19092475.x86_64-DellEMC_Customized-A09.iso
V=VBoxManage
clear;
echo -e "\e[92m\e[96m				This shell script will install in the\e[0m" | pv -qL 20
echo -e "\e[92m\e[96m				VirtualBox ESXI from Vmware Team \e[0m" | pv -qL 20
echo -e "\e[92m\e[96m 				Version $version\e[0m" $PV
echo -e "\e[92m\e[96m 				Created by Luta Dumitru luta.dumitru@oracle.com\e[0m" | pv -qL 20
clear;
echo -e "\e[92m\e[96m 				Requiriments: \e[0m" | pv -qL 20
echo -e "\e[33m\e[1;31m 				VirtualBox Version 6.1.34\e[0m" | pv -qL 20
echo -e "\e[33m\e[1;31m 				Oracle Linux Server 7.9\e[0m" | pv -qL 20
echo -e "\e[33m\e[1;31m 				ESXI from Vmware TEAM \e[0m" | pv -qL 20
echo -e "\e[33m\e[1;31m             $II\e[0m" | pv -qL 20
sleep 1;clear;
echo -e "\e[33m\e[1;31m			Where do you want to install the virtual machine?\e[0m" | pv -qL 20
read X
echo -e "\e[33m\e[1;31m			Your iso?\e[0m" | pv -qL 20
read I

echo -e "\e[33m\e[1;31m			Virtual machine name ?\e[0m" | pv -qL 20
read E
echo -e "\e[33m\e[1;31m			Memory? 2000-4000!\e[0m" | pv -qL 20
read M 
echo -e "\e[33m\e[1;31m			CPUS? 2-4!\e[0m" | pv -qL 20
read C 
echo -e "\e[33m\e[1;31m			Recap:\e[0m" | pv -qL 20
echo -e "\e[33m\e[1;31m			Install virtual machine in:\e[0m" | pv -qL 20
echo -e "\e[92m\e[96m			$X\e[0m" | pv -qL 20
echo -e "\e[33m\e[1;31m			Your iso:\e[0m" | pv -qL 20
echo -e "\e[92m\e[96m			$I\e[0m" | pv -qL 20
echo -e "\e[33m\e[1;31m			Memory is: $M \e[0m" | pv -qL 20
echo -e "\e[92m\e[96m			CPUS: \e[0m" | pv -qL 20
echo -e "\e[33m\e[1;31m			$C \e[0m" | pv -qL 20
clear;
while true; do
echo -e "\e[92m\e[96m		It's ok?? (yes/no) \e[0m"| pv -qL 20
read yn 
case $yn in 
	yes) echo -e "\e[92m\e[96m		Ok, we will proceed!\e[0m" | pv -qL 20;
		break;;
	no) echo -e "\e[92m\e[96m		Exiting...Bye!\e[0m" | pv -qL 20;
		exit;;
	*) echo -e "\e[33m\e[1;31m		Invalid response\e[0m" | pv -qL 20;;
esac
done
clear;
$V createvm --name $E --ostype "Linux_64" --register --basefolder $X
$V modifyvm $E --ioapic on --memory $M --vram 128 --nic1 intnet --cpus $C --chipset ich9
$V createhd --filename $X/$E/$E_disk.vdi --size 999000 --format VDI 
$V storagectl $E --name "SATA Controller" --add sata --controller IntelAhci
$V storageattach $E --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $X/$E/$E_disk.vdi
$V storagectl $E --name "IDE Controller" --add ide --controller PIIX4
$V storageattach $E --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $I
$V modifyvm $E --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxHeadless --startvm $E &



