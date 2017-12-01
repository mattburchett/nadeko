FROM phusion/baseimage:latest

WORKDIR /opt/

#Install Dotnet
RUN 	sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list' \
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 \
	&& apt-get update && apt-get install -y dotnet-dev-2.0.0

#Add ffmpeg3 ppa
RUN 	add-apt-repository ppa:jonathonf/ffmpeg-3

#Install required software
RUN 	apt-get update && apt-get install -y git libopus0 opus-tools libopus-dev libsodium-dev ffmpeg rsync python tzdata

#Add youtube-dl
RUN 	curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl && chmod a+rx /usr/local/bin/youtube-dl

#Download and install stable version of Nadeko
RUN 	curl -O https://raw.githubusercontent.com/mattburchett/nadeko/release/nadeko_installer_1_4.sh && chmod 755 nadeko_installer_1_4.sh && ./nadeko_installer_1_4.sh \
	&& curl -O https://raw.githubusercontent.com/mattburchett/nadeko/release/nadeko_autorestart.sh && chmod 755 nadeko_autorestart.sh
 
	
	
VOLUME ["/root/nadeko"]

CMD ["sh","/opt/nadeko_autorestart.sh"]
