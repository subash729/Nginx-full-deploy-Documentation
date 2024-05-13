# Table of Contents

- [Table of Contents](#table-of-contents)
- [Project : Webserver Administration](#project--webserver-administration)
  - [Authors](#authors)
- [1. Project Tools Selection : Nginx](#1-project-tools-selection--nginx)
  - [1.1 Project Description](#11-project-description)
  - [1.2 Init and Setup](#12-init-and-setup)
- [2. Configuration](#2-configuration)
  - [2.1 Hosting](#21-hosting)
- [Our Details](#our-details)
  - [🖥️🛠️ Support and 📞 Contact Information](#️️-support-and--contact-information)
  - [🚀 About Us](#-about-us)
    - [ YouTube Channels](#-youtube-channels)
    - [ Social Media Groups](#-social-media-groups)
  - [🔗 Contact Links](#-contact-links)
  - [📝 Feedback and Suggestions](#-feedback-and-suggestions)
 
# Project : Webserver Administration

We will learn to configure tools or software for webserver administration as server admin, Devops or cloud engineer from scratch. 

## Authors

- [Jiwan Bhattarai](https://www.linkedin.com/in/jiwanbhattarai/)
- [Subash Chaudhary](https://www.github.com/subash729)

# 1. Project Tools Selection : Nginx 
## 1.1 Project Description
We will use Nginx for following purpose
- Web hosting
- Log collection (Error/Informational)
- Digital Certificates and Security
- Reverseproxy and Loadbalancing
- Redirect and Cache

## 1.2 Init and Setup
Case 1 : Installation For Debain and Ubuntu based Systems

**Installation Through Repository**
```bash
sudo apt-get update
sudo apt-get install -y nginx
```

Case 2 : Installation For RPM based Systems
```bash
sudo yum install -y epel-release
sudo yum update
sudo yum install -y nginx
```

**Installation Through Package**
```bash
sudo apt install build-essential
wget nginx.org.
./configure
```

Case 2 : Installation For RPM based Systems
```bash
sudo yum groupinstall "Development tools"
wget nginx.org.
cd nginx-ver
./configure
```

**Setup**
```
sudo systemctl restart nginx
sudo systemctl enable nginx

sudo systemctl status nginx
```

**Error Verification**
```
sudo journactl -xeu nginx.service
```



# 2. Configuration
**Basic Syntax**
```json
Header1
Header2
.
.
.
Header_N
context_1 {
    Directive_1;
    Directive_2;
    .
    .
    context_nested_1.1{
        Directive_1.1;
        .
        Directive_N;

        }
    .
    .
    Directive_n;
    }

context_2{
    Directive1;
    Directive2;
    .
    .
    Directive;

    }
.
.
Context_N{
    .
    .

    }
```
For e.g.
<PRE>
    <B>Header</B>   : user, worker_processes, pid etc
    <B>Context</B>  : event, http, server, location etc
    <B>Directive</B>: listen, server_name, root, include, ssl_protocols, access_log, error_log, error_page etcs
</PRE>
sample config
```
server {
    listen 8080;
    listen [::]8080;

    server_name test.com;

    root /var/www/test.com/;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~* \.(css|js|gif|jpe?g|png)$ {
        expires max;
        log_not_found off;
        access_log off;
    }

    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;

    location = /50x.html {
        root /usr/share/nginx/html;
    }

    access_log /var/log/nginx/test.com/access.log;
    error_log /var/log/nginx/test.com/error.log;
}

```
## 2.1 Hosting


=================================================================================================
# Our Details
<div align="justify">
<B>"IT Education Nepal"</B>  and <B>"Neplese IT study community"</B> work together to provide freely available and complete IT education to everybody, including basic to advanced courses like programming, networking, system and server administration, Cloud infrastructure, IT security and graphic design. This effort is motivated by a desire to provide great education for free, with a focus on empowering students, teachers, and IT professionals equally. We aim to transform education by creating a culture of continuous learning and knowledge sharing for the benefit of Nepali society through a youth-driven, non-profit platform. <br>
<br>

<B><U>CCIE #60261 Jiwan Bhattarai</U></B> sir leads this study community, along with our dedicated team, to improve IT education literacy in Nepali. Our mission is to provide learners with practical skills and technical knowledge while also developing a collaborative supportive learning environment. Join our team to gain for more contribution.
</div>

## 🖥️🛠️ Support and 📞 Contact Information

For support or inquiries, feel free to reach out to us through the following channels:

* **<U>Jiwan Bhattarai</U>**
  - **📧 Email**: [pingjiwan@gmail.com](mailto:pingjiwan@gmail.com)
  - **📱 Phone**: +977 9866358671
  - **Viber/Whatsapp/Telegram**: +977 9866358671

* **<U>Subash Chaudhary</u>**
  - **📧 Email**: [subaschy729@gmail.com](mailto:subaschy729@gmail.com)
  - **📱 Phone**: +977 9823827047
  - **Viber/Whatsapp/Telegram**: +977 9823827047

## 🚀 About Us
<div align="justify">
We are a team of security professionals and DevOps Engineers dedicated to ensuring robust network security and efficient cloud infrastructure. Our security expertise includes certifications such as CCNA and CCNP (2012), as well as achieving the prestigious CCIE #60261 (2018). Specializing in technologies like CISCO ASA, FTD, ISE, PaloAlto, and Fortinet, we provide multivendor network security solutions. Additionally, our team holds certifications as Certified Ethical Hackers (CEH) and in Redhat Linux, enabling us to effectively safeguard digital assets.<br>
<br>

In addition to our security focus, we excel in DevOps practices, specializing in Network and Systems, as well as Cloud technologies. Our proficiency extends to Kubernetes, containerization, Continuous Integration and Continuous Deployment (CI/CD), and Infrastructure as Code (IAC) using industry-standard tools like Terraform and CloudFormation. With our comprehensive skill set, we ensure both security and efficiency in our clients' IT environments.
</div>

###  <img src="screenshots/template-image/youtube-logo.png" width="65" height="50"> <span style="font-size: 59px;">YouTube Channels</span>
 

<p align="center" width="100%">
  <a href="https://www.youtube.com/@NepaliITStudyCommunity" style="text-align: center;">
    <img width="35%" src="screenshots/template-image/youtube-nistc.png" alt="Nepali IT Study Community"  height="300" style="margin-right: 200px;" hspace="20">
  </a>
  <a href="https://www.youtube.com/@iteducationnepal-6725" style="text-align: center;">
    <img width="35%" src="screenshots/template-image/youtube-itenp.png" alt="IT Education Nepal" height="300" hspace="10">
  </a>
</div>


<div align="center">

<a href="https://www.youtube.com/channel/UCeMWyKMRaWt06_cxyajaUtg?sub_confirmation=1">
  <img src="https://img.shields.io/youtube/channel/subscribers/UCeMWyKMRaWt06_cxyajaUtg?color=%09%23FF0000&logo=youtube&style=for-the-badge" alt="YouTube subscribers" hspace="20" >
  <img src="https://img.shields.io/youtube/channel/views/UCeMWyKMRaWt06_cxyajaUtg?color=%09%23FF0000&logo=youtube&style=for-the-badge" alt="YouTube video views">
</a>

<a href="https://www.youtube.com/channel/UCJinKAyRTpHJOPE0YgCMhog?sub_confirmation=1">
  <img src="https://img.shields.io/youtube/channel/subscribers/UCJinKAyRTpHJOPE0YgCMhog?color=%09%23FF0000&logo=youtube&style=for-the-badge" alt="YouTube subscribers"  hspace="30">
  <img src="https://img.shields.io/youtube/channel/views/UCJinKAyRTpHJOPE0YgCMhog?color=%09%23FF0000&logo=youtube&style=for-the-badge" alt="YouTube video views">
</a>
</div>

###  <img src="screenshots/template-image/social-media.png" width="65" height="50"> <span style="font-size: 59px;">Social Media Groups</span>
click on icon to join the the group of respective platform
<p align="center" width="100%">
  <a href="https://t.me/jiwanbhattarai" style="text-align: center;">
    <img width="30%" src="screenshots/template-image/whatsapp-logo.png" alt="Learning Updates" height="300" style="margin-right: 100px;" hspace="30" >
  </a>
   <a href="https://t.me/jiwanbhattarai" style="text-align: center;">
    <img width="40%" src="screenshots/template-image/telegram-logo.png" alt="Jiwan Bhattarai Official" height="300" >
  </a>
</div>

<div align="left">
  <a href="https://t.me/jiwanbhattarai" style="text-align: center;">
  <img src="https://img.shields.io/badge/WhatsApp%20Group%20Members-102-brightgreen?logo=whatsapp&style=for-the-badge"  hspace="80"> 
  </a>

  <a href="https://t.me/jiwanbhattarai" style="text-align: center;">
    <img src="https://img.shields.io/badge/Telegram%20Group%20Members-445-blue?logo=telegram&style=for-the-badge">
  </a>
</div>

## 🔗 Contact Links
<!-- picture section -->

<p>
  <a href="https://t.me/pingccie" style="text-align: center;">
    <img src="screenshots/template-image/CCIE-Jiwan-bhattrai-sir.png" alt="Learning Updates" width="400" height="250" style="margin-right: 100px;" hspace="50" >
  </a>
<p>

<!-- Comment for link section -->


<p align="left" style="text-align: left;">
  <a href="http://jiwanbhattarai.com/" target="_blank">
    <img src="https://img.shields.io/badge/Jiwan-CCIE_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white" alt="Jiwan's CCIE Portfolio" />
  </a><br>
  <a href="https://www.linkedin.com/in/jiwanbhattarai/" target="_blank">
    <img src="https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn" />
  </a><br>
  <a href="https://www.instagram.com/jiwanbhattaraiofficial/" target="_blank">
    <img src="https://img.shields.io/badge/Instagram%20-%20CCIE%20Professional%20-%23E4405F?style=for-the-badge&logo=instagram&logoColor=white" alt="Instagram - CCIE Professional" />
  </a><br>
  <a href="https://www.instagram.com/yogijiwan/" target="_blank">
    <img src="https://img.shields.io/badge/Instagram%20-%20Yogi%20Personal%20-%23E4405F?style=for-the-badge&logo=instagram&logoColor=white" alt="Instagram - Yogi Personal" />
  </a><br>
  <a href="https://twitter.com/CCIEJIWAN" target="_blank">
    <img src="https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white" alt="Twitter" />
  </a><br>
</p>


<p>
    <a href="https://t.me/subash729" style="text-align: center;">
    <img src="screenshots/template-image/subash-chaudhary.png" alt="Jiwan Bhattarai Official" width="400" height="250" hspace="50">
  </a>

<p align="left">
  <a href="https://github.com/subash729/" target="_blank">
    <img src="https://img.shields.io/badge/Subash-portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white" alt="Subash's Portfolio" />
  </a><br>
  <a href="https://www.linkedin.com/in/subash-chaudhary-it-engineer/" target="_blank">
    <img src="https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn" />
  </a><br>
  <a href="https://www.instagram.com/rambati.subash.chaudhary.729/" target="_blank">
    <img src="https://img.shields.io/badge/instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white" alt="Instagram" />
  </a><br>
  <a href="https://twitter.com/Subash729" target="_blank">
    <img src="https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white" alt="Twitter" />
  </a><br>
</p>




## 📝 Feedback and Suggestions 

We welcome your feedback, suggestions, and ideas for improvement! Your input helps us enhance our services and better cater to your needs. If you have any comments, questions, or recommendations, please don't hesitate to reach out to us through the following channels:

**<u>Jiwan Bhattarai</u>**
- **Email:** [pingjiwan@gmail.com](mailto:pingjiwan@gmail.com)
- **Phone:** +977 9866358671

**<u>Subash Chaudhary</u>**
- **Email:** [subaschy729@gmail.com](mailto:subaschy729@gmail.com)
- **Phone:** +977 9823827047

Alternatively, you can submit feedback directly through GitHub:

- **GitHub Issues:** [Submit Feedback](https://github.com/subash729/Documentation-Reference/issues/new)

We appreciate your time and value your input, as it helps us continuously improve and better serve your needs.

