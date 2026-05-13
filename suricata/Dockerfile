FROM ubuntu:22.04
RUN apt update && apt upgrade -y
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:oisf/suricata-stable
RUN apt install -y suricata jq
