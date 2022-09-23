![lente](https://user-images.githubusercontent.com/68069659/169600300-9e68d3e0-8406-4eb6-a641-88525646bad3.gif)
[![os](https://img.shields.io/badge/os-linux-red)](https://www.linux.org/)
[![script](https://img.shields.io/badge/script-bash-orange)](https://www.gnu.org/software/bash/)
[![license](https://img.shields.io/badge/license-Apache--2.0-yellowgreen)](https://apache.org/licenses/LICENSE-2.0)
[![donate](https://img.shields.io/badge/donate-wango-blue)](https://www.wango.org/donate.aspx)
# trivy scan

[trivy](https://github.com/aquasecurity/trivy) is an opensource project for scanning  vulnerabilities in container images, file systems, and Git repositories

# first you need

[os linux](https://www.linux.org/pages/download/)

[docker](https://docs.docker.com/engine/install/)

# get started

### open your terminal 


clone  repository:

```bash
cd ~ && git clone https://github.com/william89731/trivy-scan 
```
make your [images-list.txt](https://github.com/william89731/trivy-scan/blob/main/images-list.txt)

set alias:

```bash
sudo nano ~/.bashrc
```
(add this line:) ``` alias scan='bash ~/trivy-scan/scan.sh ~/trivy-scan/images-list.txt' ```   

save and exit:

```ctrl+s  ctrl+x```

reload:  

```bash
source ~/.bashrc
```

launch script:

```bash
scan
```

![script](https://user-images.githubusercontent.com/68069659/169677210-5bfd94ef-386c-4a2c-aa4e-de102199c68d.gif)


```see the scan result in the report.txt```

![Screenshot from 2022-05-22 05-47-19](https://user-images.githubusercontent.com/68069659/169677557-1297453c-d3c2-43b2-b31f-8be551387dd2.png)












