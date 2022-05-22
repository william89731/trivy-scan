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
cd ~ && git clone https://github.com/william89731/trivy-scan && chmod +X ~/trivy-scan/scan.bash
```
make your [images-list.txt](https://github.com/william89731/trivy-scan/blob/main/images-list.txt)

set alias:

```bash
sudo nano ~/.bashrc
```
(add this line:) ``` alias scan='~/trivy-scan/scan.bash ~/trivy-scan/images-list.txt' ```  (save and exit)

```bash
source ~/.bashrc
```

launch script:

```bash
scan
```

![Screencast-from-20-05-2022-23_16_07](https://user-images.githubusercontent.com/68069659/169612305-a9ff1a80-ae9e-47a0-be13-50efe92562ed.gif)


```see the scan result in the report.txt```











