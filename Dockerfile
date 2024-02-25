FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
#Install tzdata in non-interactive mode, otherwise it asks for timezones.
RUN apt-get install -y --no-install-recommends tzdata
RUN apt-get install -y unzip

# COPY bin /root/bin
# COPY otatools /root/otatools
# COPY extract.sh /root/

WORKDIR /root

ENTRYPOINT ["bash"]